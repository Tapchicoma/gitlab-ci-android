#
# GitLab CI Android Runner
#
#
FROM jangrewe/gitlab-ci-android

ENV VERSION_NDK "r12b"

ENV ANDROID_NDK_HOME "/ndk"
ENV PATH "$PATH:${ANDROID_NDK_HOME}/"

RUN apt-get -qq update && \
    apt-get install -qqy --no-install-recommends \
        wget \
        build-essential \
        iputils-ping
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD https://dl.google.com/android/repository/android-ndk-${VERSION_NDK}-linux-x86_64.zip /ndk.zip

RUN unzip /ndk.zip -d / && \
    rm -v /ndk.zip && \
    mv /android-ndk-${VERSION_NDK} /ndk

# Patch the NDK, for some reason the x64 & x86 paths are goofed up
RUN ln -s ${ANDROID_NDK_HOME}/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/ ${ANDROID_NDK_HOME}/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86 \
    && ln -s ${ANDROID_NDK_HOME}/toolchains/x86_64-4.9/prebuilt/linux-x86_64/ ${ANDROID_NDK_HOME}/toolchains/x86_64-4.9/prebuilt/linux-x86 \
    && ln -s ${ANDROID_NDK_HOME}/toolchains/mips64el-linux-android-4.9/prebuilt/linux-x86_64/ ${ANDROID_NDK_HOME}/toolchains/mips64el-linux-android-4.9/prebuilt/linux-x86 \
    && ln -s ${ANDROID_NDK_HOME}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64 ${ANDROID_NDK_HOME}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86 \
    && ln -s ${ANDROID_NDK_HOME}/toolchains/x86-4.9/prebuilt/linux-x86_64 ${ANDROID_NDK_HOME}/toolchains/x86-4.9/prebuilt/linux-x86 \
    && ln -s ${ANDROID_NDK_HOME}/toolchains/mipsel-linux-android-4.9/prebuilt/linux-x86_64 ${ANDROID_NDK_HOME}/toolchains/mipsel-linux-android-4.9/prebuilt/linux-x86

# Add emulator stuff
ADD https://raw.githubusercontent.com/travis-ci/travis-cookbooks/precise-stable/ci_environment/android-sdk/files/default/android-wait-for-emulator /usr/local/bin/android-wait-for-emulator
RUN chmod +x /usr/local/bin/android-wait-for-emulator