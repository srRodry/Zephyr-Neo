#!/usr/bin/env bash
set -euo pipefail

root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
engine="$root/engines/zephyr-x"
mobile="$root/engines/zephyr-mobile"
build="$engine/build/native/core"

if [[ ! -f "$engine/native/CMakeLists.txt" ]]; then
  echo "Initialize the Zephyr-x source with git submodule update --init engines/zephyr-x." >&2
  exit 1
fi
if [[ ! -f "$mobile/emulator-core/build.gradle" ]]; then
  echo "Initialize Zephyr-Mobile with git submodule update --init engines/zephyr-mobile." >&2
  exit 1
fi

: "${ANDROID_NDK:?Set ANDROID_NDK to the NDK directory documented by Zephyr-x}"
: "${NC_DEPS:?Set NC_DEPS to the native dependencies directory documented by Zephyr-x}"
ANDROID_NDK="$(cd -- "$ANDROID_NDK" && pwd)"
NC_DEPS="$(cd -- "$NC_DEPS" && pwd)"

cmake -S "$engine/native" -B "$build" -G Ninja \
  -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake" \
  -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=android-28 \
  -DCMAKE_BUILD_TYPE=Release -DNC_DEPS="$NC_DEPS"
cmake --build "$build" --target hakuxcore
ANDROID_NDK="$ANDROID_NDK" bash "$engine/tools/native/app-libs.sh" "$build"

mobile_build="$root/integration/build/mobile-native"
mobile_jni="$root/integration/build/neo360-jni/arm64-v8a"
cmake -S "$mobile/emulator-core/src/main/cpp" -B "$mobile_build" -G Ninja \
  -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake" \
  -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=android-29 \
  -DCMAKE_BUILD_TYPE=Release -DADRENOTOOLS_HOOK_PREFIX=neo360_
cmake --build "$mobile_build" --target emu hardware_ProcessorInfo main_hook \
  file_redirect_hook gsl_alloc_hook hook_impl

ndk_strip="$(sed -n 's/^CMAKE_STRIP:FILEPATH=//p' "$mobile_build/CMakeCache.txt")"
mkdir -p "$mobile_jni"
hook_dir="$mobile_build/xenia/third_party/libadrenotools/src/hook"
for library in "$mobile_build/libe.so" "$mobile_build/libhardware_ProcessorInfo.so" \
  "$hook_dir/libneo360_main_hook.so" "$hook_dir/libneo360_file_redirect_hook.so" \
  "$hook_dir/libneo360_gsl_alloc_hook.so" "$hook_dir/libneo360_hook_impl.so"; do
  "$ndk_strip" --strip-unneeded -o "$mobile_jni/${library##*/}" "$library"
done

exec "$engine/android/gradlew" -p "$root/integration" :app:assembleDebug
