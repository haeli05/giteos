#!/usr/bin/env bash
set -o errexit

## Omnibus GitLab Documentation
#  https://docs.gitlab.com/omnibus/docker/

# change to script's directory
ch "$(dirname "$0")/gitlab_docker"

echo "=== run docker container from the gitlab ce docker image ==="
docker run --detach \
--hostname giteos.com \
--publish 443:443 --publish 80:80 --publish 22:22 \
--name gitlab \
--restart always \
--volume /srv/gitlab/config:/etc/gitlab \
--volume /srv/gitlab/logs:/var/log/gitlab \
--volume /srv/gitlab/data:/var/opt/gitlab \
gitlab/gitlab-ce:latest

if [ "$1" != "--nolog" ]
then
    echo "=== follow gitlab logs ==="
    docker logs gitlab --follow
fi