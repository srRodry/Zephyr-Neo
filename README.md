# Zephyr-Neo

## Base Android desta branch

O [Zephyr-x](https://github.com/srRodry/Zephyr-x) é a base da interface Android e do núcleo de **Xbox original**. O submódulo fixa a revisão usada e inclui o código do hakuX, com JIT FEX, renderização Vulkan e suporte a drivers Turnip em Adreno.

```sh
git submodule update --init engines/zephyr-x
cd engines/zephyr-x
git submodule update --init external/fex
git -C external/fex submodule update --init External/fmt External/range-v3 \
  External/rpmalloc External/unordered_dense External/xxhash Source/Common/cpp-optparse
cd ../..
ANDROID_NDK=/caminho/do/ndk NC_DEPS=/caminho/das/dependencias ./build-android.sh
```

As revisões das dependências e o ambiente Android estão no [guia de compilação do Zephyr-x](https://github.com/srRodry/Zephyr-x/blob/a7cdb5a975e31730d488c47f6f10440b16c1e6f4/android/README.md). O script usa o app de depuração da base, com o identificador `com.rfandango.haku_x.debug`. A integração do módulo de Xbox 360 do Zephyr-Mobile fica pendente.

## Árvore herdada do Xenra

Zephyr-Neo é um projeto de emulação de Xbox original para Android, derivado de Xenra/XaniteOG. A árvore atual inclui o núcleo xemu, a interface Android em Kotlin e os renderizadores Vulkan e OpenGL do chip gráfico NV2A.

## Estado do código publicado

- **Xbox original:** núcleo xemu e código dos renderizadores em [app/main/cpp/hw/xbox/nv2a/pgraph](app/main/cpp/hw/xbox/nv2a/pgraph).
- **Xbox 360:** o núcleo Xenia Edge mencionado no histórico do Xenra não está presente neste checkout. A árvore atual só permite investigar a renderização do Xbox original.
- **Build Android:** o [Gradle](app/build.gradle) usa os fontes em `app/main/`. A compilação nativa ainda depende da recuperação de `app/main/cpp/CMakeLists.txt` e dos arquivos de build das dependências vendorizadas. O [CMakeLists.txt na raiz](CMakeLists.txt) é um esboço sem alvos de compilação.

## History & Origins

The upstream Xenra project described its Xbox Original and Xbox 360 backends as xemu and Xenia Edge. The sections below retain upstream context and contributor credits.

---

## Upstream features

- **Hardware Detection:**  
  Automatically identifies your device's hardware (GPU, RAM) and optimizes settings for peak performance.

- **Performance Scaling:**  
  You can manually adjust the resolution and performance in settings for experiment or low end devices.

---

## Android build configuration

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
