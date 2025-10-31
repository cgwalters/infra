# Validate devcontainer.json syntax
devcontainer-validate:
	npx --yes @devcontainers/cli read-configuration --workspace-folder .

# Build devenv image with local tag
devenv-build:
	cd devenv && podman build --jobs=4 -t localhost/bootc-devenv-debian .
