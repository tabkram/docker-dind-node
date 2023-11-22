#!/bin/sh
exec dockerd-entrypoint.sh ${DOCKER_OPTS} &>/var/log/docker.log &
/bin/sh -c "ATTEMPT=0; while [ \"\${ATTEMPT}\" -lt \"5\" ]; do if [ -e /var/run/docker.sock ]; then exit 0; fi; ATTEMPT=\$((ATTEMPT+1)); sleep 1; done;"
/bin/sh