# Gitlab CI Android build runner

This build runner can build android projects and execute both unit and instrumentation tests

With inspiration taken from:
 - https://github.com/reddit/docker-android-build/blob/master/Dockerfile
 - https://github.com/jangrewe/gitlab-ci-android

## Included Tools
| Tool  | Description  |
|-------|--------------|
| android-wait-for-emulator | Travis-ci tool available from [Github](https://github.com/travis-ci/travis-cookbooks/blob/precise-stable/ci_environment/android-sdk/files/default/android-wait-for-emulator) |
| android-update-sdk        | Installs the specified SDK tool packages |