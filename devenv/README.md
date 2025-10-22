# A devcontainer for work on bootc-org projects

This container image is suitable for use on
developing projects in the bootc-dev organization,
especially bootc.

It includes all tools used in the Justfile
for relevant projects.

## Base image

At the current time the default is using Debian sid, mainly because
other parts of the upstream use CentOS Stream as a *target system*
base, but this helps prove out the general case of "src != target"
that is a philosophy of bootc (and containers in general)
as well as just helping prepare/motivate for bootc-on-Debian.

## Building locally

See the `Justfile`, but it's just a thin wrapper around a default
of `podman build` of this directory.
