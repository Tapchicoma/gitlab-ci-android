#
# Gitlab ci multirunner
#

FROM ubuntu:16.04

# Installing gitlib-ci-multirunner
RUN curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh \
    | bash \
    && apt-get install gitlab-ci-multi-runner
