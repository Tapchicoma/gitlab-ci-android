FROM 51systems/gitlab-ci-android

# Install the emulators stuff
RUN android-update-sdk "sys-img-armeabi-v7a-android-21,\
    sys-img-armeabi-v7a-google_apis-21"

# Create the default emulators
RUN echo "no" | android create avd \
                --force \
                --device "Nexus 5" \
                --name nexus5_21 \
                --target android-21 \
                --abi default/armeabi-v7a \
                --skin WVGA800 \
                --sdcard 512M

# Warm up the emulators
RUN android-start-emulator nexus5_21 && adb -s emulator-5554 emu kill