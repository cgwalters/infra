#!/bin/bash
set -euo pipefail
# Set things up so that podman can run nested inside the privileged
# docker container of a codespace.

# Fix the propagation
sudo mount -o remount --make-shared /

# This is actually safe to expose to all users really, like Fedora derivatives do
chmod a+rw /dev/kvm

# Handle nested cgroups
sed -i -e 's,^#cgroups =.*,cgroups = "no-conmon",' /usr/share/containers/containers.conf
sed -i -e 's,^#cgroup_manager =.*,cgroup_manager = "cgroupfs",' /usr/share/containers/containers.conf
