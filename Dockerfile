#
# GitLab CI Android Runner
#
#
FROM ubuntu:16.04

ENV VERSION_SDK_TOOLS "25.1.7"
ENV VERSION_NDK "r12b"

ENV DEBIAN_FRONTEND noninteractive

ENV ANDROID_HOME "/sdk"
ENV PATH "$PATH:${ANDROID_HOME}/tools"

ENV ANDROID_NDK_HOME "/ndk"
ENV PATH "$PATH:${ANDROID_NDK_HOME}/"

RUN apt-get -qq update && \
    apt-get install -qqy --no-install-recommends \
        curl \
        html2text \
        openjdk-8-jdk \
        libc6-i386 \
        lib32stdc++6 \
        lib32gcc1 \
        lib32ncurses5 \
        lib32z1 \
        unzip \
        wget \
        build-essential \
        expect \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fix the java certs
RUN rm -f /etc/ssl/certs/java/cacerts; \
    /var/lib/dpkg/info/ca-certificates-java.postinst configure

# Install the SDK tools
ADD http://dl.google.com/android/repository/tools_r${VERSION_SDK_TOOLS}-linux.zip /tools.zip
RUN unzip /tools.zip -d /${ANDROID_HOME} && \
    rm -v /tools.zip

# Install the NDK tools
ADD https://dl.google.com/android/repository/android-ndk-${VERSION_NDK}-linux-x86_64.zip /ndk.zip
RUN unzip /ndk.zip -d / && \
    rm -v /ndk.zip && \
    mv /android-ndk-${VERSION_NDK} /${ANDROID_NDK_HOME}

# Patch the NDK, for some reason the x64 & x86 paths are goofed up
RUN ln -s ${ANDROID_NDK_HOME}/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/ ${ANDROID_NDK_HOME}/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86 \
    && ln -s ${ANDROID_NDK_HOME}/toolchains/x86_64-4.9/prebuilt/linux-x86_64/ ${ANDROID_NDK_HOME}/toolchains/x86_64-4.9/prebuilt/linux-x86 \
    && ln -s ${ANDROID_NDK_HOME}/toolchains/mips64el-linux-android-4.9/prebuilt/linux-x86_64/ ${ANDROID_NDK_HOME}/toolchains/mips64el-linux-android-4.9/prebuilt/linux-x86 \
    && ln -s ${ANDROID_NDK_HOME}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64 ${ANDROID_NDK_HOME}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86 \
    && ln -s ${ANDROID_NDK_HOME}/toolchains/x86-4.9/prebuilt/linux-x86_64 ${ANDROID_NDK_HOME}/toolchains/x86-4.9/prebuilt/linux-x86 \
    && ln -s ${ANDROID_NDK_HOME}/toolchains/mipsel-linux-android-4.9/prebuilt/linux-x86_64 ${ANDROID_NDK_HOME}/toolchains/mipsel-linux-android-4.9/prebuilt/linux-x86

# Add travis tools
ADD https://raw.githubusercontent.com/appunite/docker/eacea57245e95f112c55c41b41d2c0cf218fd334/android-java8/tools/android-accept-licenses.sh /usr/local/bin/android-accept-licenses
RUN chmod +x /usr/local/bin/android-accept-licenses

ADD https://raw.githubusercontent.com/travis-ci/travis-cookbooks/ca800a93071a603745a724531c425a41493e70ff/community-cookbooks/android-sdk/files/default/android-wait-for-emulator /usr/local/bin/android-wait-for-emulator
RUN chmod +x /usr/local/bin/android-wait-for-emulator

# Add our tools
ADD android-update-sdk /usr/local/bin/android-update-sdk
RUN chmod +x /usr/local/bin/android-update-sdk


# Install the SDK stuff

RUN android-update-sdk "platform-tools,\
    tools,\
    build-tools-21,\
    build-tools-21.0.1,\
    build-tools-21.0.2,\
    build-tools-21.1,\
    build-tools-21.1.1,\
    build-tools-21.1.2,\
    build-tools-22,\
    build-tools-22.0.1,\
    build-tools-23.0.0,\
    build-tools-23.0.1,\
    build-tools-23.0.2,\
    build-tools-23.0.3,\
    android-21,\
    android-22,\
    android-23,\
    android-24,\
    addon-google_apis_x86-google-21,\
    extra-android-support,\
    extra-android-m2repository,\
    extra-google-m2repository,\
    extra-google-google_play_services,\
    sys-img-armeabi-v7a-android-21"