#!/usr/bin/env bash
set -euo pipefail

root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
engine="$root/engines/zephyr-x"
build="$engine/build/native/core"

if [[ ! -f "$engine/native/CMakeLists.txt" ]]; then
  echo "Initialize the Zephyr-x source with git submodule update --init engines/zephyr-x." >&2
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

cd -- "$engine/android"
./gradlew :app:assembleDebug
