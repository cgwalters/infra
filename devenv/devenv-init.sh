#!/bin/bash
set -euo pipefail
# Set things up so that podman can run nested inside the privileged
# docker container of a codespace.

if test "${CODESPACES:-}" != 1; then
    exit 0
fi
echo "Detected codespace, initializing"

# First, ensure that /var/lib/containers (storage) is on the persistent
# mounted volume, not overlay so we don't have overlay-on-overlay issues.
# Confusingly in codespaces, /tmp is a (large) persistent volume instead of
# it being at /var/tmp as one might expect.
rm -rf /var/lib/containers && ln -sr /tmp/containers-storage /var/lib/containers

# Disable the conmon cgroup
echo 'cgroup = "no-conmon"' >> /usr/lib/containers/containers.conf
