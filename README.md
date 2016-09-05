# Gitlab CI Android build runner

This build runner can build android projects and execute both unit and instrumentation tests

SDK and NDK images are included in the `sdk` directory. Dockerfile that pulls in emulators in `emulator`
directory.

With inspiration taken from:
 - https://github.com/51systems/gitlab-ci-android
 - https://github.com/reddit/docker-android-build/blob/master/Dockerfile
 - https://github.com/jangrewe/gitlab-ci-android
 - https://hub.docker.com/r/neroinc/fedora-android/

## Included Tools
| Tool  | Description  |
|-------|--------------|
| android-wait-for-emulator | Travis-ci tool available from [Github](https://github.com/travis-ci/travis-cookbooks/blob/precise-stable/ci_environment/android-sdk/files/default/android-wait-for-emulator) |
| android-update-sdk        | Installs the specified SDK tool packages |
| android-start-emulator    | Starts the emulator that matches the name specified on the command line |
