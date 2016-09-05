FROM tapchicoma/gitlab-android-runner

ENV EMULATOR_VERSION=23

# Install the emulators stuff
RUN android-update-sdk "sys-img-x86-android-${EMULATOR_VERSION},\
    sys-img-x86-google_apis-${EMULATOR_VERSION}"

# Create the default emulators
RUN android create avd \
            --force \
            --device "Nexus 5" \
            --name nexus5_${EMULATOR_VERSION} \
            --target android-${EMULATOR_VERSION} \
            --abi default/x86 \
            --skin WVGA800 \
            --sdcard 512M

# Warm up the emulators
RUN android-start-emulator nexus5_${EMULATOR_VERSION} && adb -s emulator-5554 emu kill
