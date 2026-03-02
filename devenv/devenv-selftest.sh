#!/bin/bash
# Test the devcontainer environment (nested podman, VMs, agent skills, etc.)
# This script is designed to be run inside the container after devenv-init.sh
# has already been executed (e.g., via postCreateCommand).
set -euo pipefail

echo "=== Testing nested podman and VMs ==="

echo "Podman version:"
podman --version

echo "Podman info (rootless):"
podman info --format '{{.Host.Security.Rootless}}'

# Use CentOS Stream 10 as the test image for both container and VM
image="quay.io/centos-bootc/centos-bootc:stream10"

echo "Pulling $image..."
podman pull "$image"

echo "Running nested container..."
podman run --rm "$image" echo "Hello from nested podman!"

echo "=== Nested container test passed ==="

# Test bcvk (VM) if available and /dev/kvm exists
if command -v bcvk >/dev/null 2>&1 && [ -e /dev/kvm ]; then
    echo ""
    echo "=== Testing bcvk VM ==="
    echo "bcvk version:"
    bcvk --version
    
    echo "Running bcvk ephemeral VM with SSH..."
    bcvk ephemeral run-ssh "$image" -- echo "Hello from bcvk VM!"
    
    echo "=== bcvk VM test passed ==="
else
    echo ""
    echo "=== Skipping bcvk VM test (bcvk not available or /dev/kvm missing) ==="
fi

# Test agent skills are installed
echo ""
echo "=== Testing agent skills ==="
skills_dir="$HOME/.config/opencode/skills"
if [ -d "$skills_dir" ]; then
    skill_count=$(find "$skills_dir" -name 'SKILL.md' | wc -l)
    echo "Found $skill_count skill(s) in $skills_dir"
    if [ "$skill_count" -eq 0 ]; then
        echo "ERROR: No SKILL.md files found in $skills_dir"
        exit 1
    fi
    echo "=== Agent skills test passed ==="
else
    echo "ERROR: Skills directory $skills_dir not found"
    exit 1
fi

echo ""
echo "=== All tests passed ==="
