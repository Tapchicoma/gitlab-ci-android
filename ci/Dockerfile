#
# Gitlab ci multirunner
#

FROM ubuntu:16.04

# Installing gitlib-ci-multirunner
RUN apt-get -qq update \
    && apt-get install -qqy --no-install-recommends curl ca-certificates \
    && curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | bash \
    && apt-get install -qqy --no-install-recommends gitlab-ci-multi-runner \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
