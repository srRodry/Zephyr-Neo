# Zephyr-Neo

A prévia Android reúne o **Xbox original** do [Zephyr-x](https://github.com/srRodry/Zephyr-x) (hakuX/FEX) e o **Xbox 360** do [Zephyr-Mobile](https://github.com/srRodry/Zephyr-Mobile) (Xenia ARM64) em um único APK. O seletor abre a biblioteca de cada console. Cada jogo roda no processo do seu núcleo, com suas próprias bibliotecas de driver Vulkan.

## Compilação da prévia

```sh
git submodule update --init engines/zephyr-x engines/zephyr-mobile
git -C engines/zephyr-x submodule update --init external/fex
git -C engines/zephyr-x/external/fex submodule update --init \
  External/fmt External/range-v3 External/rpmalloc External/unordered_dense \
  External/xxhash Source/Common/cpp-optparse

ANDROID_NDK=/caminho/do/ndk NC_DEPS=/caminho/das/dependencias ./build-android.sh
```

Use JDK 21, plataforma Android 36, Build Tools 36.1.0, NDK 29.0.14206865, CMake 3.30.3, Ninja, Python 3, `glslangValidator`, `spirv-opt` e `spirv-dis`. Defina `ANDROID_HOME` ou configure `sdk.dir` em `integration/local.properties`. O CMake e as ferramentas de shaders precisam estar no `PATH`.

Para `NC_DEPS`, consulte as versões no [guia do Zephyr-x](https://github.com/srRodry/Zephyr-x/blob/a7cdb5a975e31730d488c47f6f10440b16c1e6f4/android/README.md). Use o commit `26be815b` do libslirp, que fornece `slirp_ssize_t`.

O APK de depuração fica em `engines/zephyr-x/android/app/build/outputs/apk/debug/`. O pacote é `com.pixelcode.zephyrneo.debug`, para Android ARM64 a partir da API 29. No primeiro acesso, cada biblioteca precisa da seleção de pasta de jogos no novo aplicativo.

A árvore histórica do Xenra fica em `app/main/`. O build desta prévia usa `integration/` e os dois submódulos.

## History & Origins

The upstream Xenra project described its Xbox Original and Xbox 360 backends as xemu and Xenia Edge. The sections below retain upstream context and contributor credits.

---

## Upstream features

- **Hardware Detection:**  
  Automatically identifies your device's hardware (GPU, RAM) and optimizes settings for peak performance.

- **Performance Scaling:**  
  You can manually adjust the resolution and performance in settings for experiment or low end devices.

---

## Historical Xenra build configuration

- The current Gradle configuration declares a minimum Android API level of 28 and the `arm64-v8a` ABI.
- Runtime compatibility remains to be verified on a built APK.

---

## Contributing

If you want to contribute as a developer, please contact us in discord.

- **yebot32** is the developer and owner
- **Ali alsaadi** was the founder of the emulator

---

## DISCLAIMER !

Xenra is an open-source project and is not affiliated with or endorsed by Microsoft in any way. This project is intended for educational and research purposes as we continue developing and porting the emulator to Android.

We do not condone piracy. BIOS files and game backups must be legally owned. While emulator software itself is legal, downloading or distributing copyrighted BIOS files or games without ownership is illegal. Please be responsible and cautious online.

---

## Xenra website and socials

- **Website:** [dev-ali2008.github.io/xenraOG.io/](https://dev-ali2008.github.io/xenraOG.io/)
- **Discord:** [Join Server](https://discord.gg/U5kytJ4dub)
- **Telegram:** [t.me/xenraOG](https://t.me/xenraOG)
- **GitHub:** [github.com/dev-Ali2008/xenraOG](https://github.com/dev-Ali2008/xenraOG)
- **YouTube:** [@emulator_xenraog](https://youtube.com/@emulator_xenraog?si=s4GLzSSLWEG4fne3)
- **Patreon:** [Xanite Membership](https://www.patreon.com/cw/Xanite/membership)
