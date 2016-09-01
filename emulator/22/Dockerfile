FROM 51systems/gitlab-ci-android

ENV EMULATOR_VERSION=22

# Install the emulators stuff
ONBUILD RUN android-update-sdk "sys-img-armeabi-v7a-android-${EMULATOR_VERSION},\
    sys-img-armeabi-v7a-google_apis-${EMULATOR_VERSION}"

# Create the default emulators
ONBUILD RUN echo "no" | android create avd \
                --force \
                --device "Nexus 5" \
                --name nexus5_${EMULATOR_VERSION} \
                --target android-${EMULATOR_VERSION} \
                --abi default/armeabi-v7a \
                --skin WVGA800 \
                --sdcard 512M

# Warm up the emulators
ONBUILD RUN android-start-emulator nexus5_${EMULATOR_VERSION} && adb -s emulator-5554 emu kill