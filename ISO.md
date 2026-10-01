# ISO

For a fresh install, generate the ISO with the `Server` installer variant. It prompts for a user account during Anaconda installation. The `flatpak_refs/` directory is passed to the ISO builder, which bundles the listed Flathub refs for installation as part of OS deployment.

These refs are included in ISO-based installations only; they are not embedded in the published OCI image and will not be installed when rebasing an existing system. The image recipes intentionally do not use BlueBuild's `default-flatpaks` module.

Run this on a Fedora Atomic host with Podman and network access. Set `IMAGE_NAME=borealis-nvidia` to generate the NVIDIA image instead.

```bash
IMAGE_NAME=${IMAGE_NAME:-borealis}
IMAGE=ghcr.io/jedace07/$IMAGE_NAME:latest
VERSION=$(podman run --rm --entrypoint sh "$IMAGE" -c '. /etc/os-release; printf "%s" "$VERSION_ID"')
mkdir -p build

podman run --rm --privileged \
  --volume "$PWD:/github/workspace" \
  --volume "$PWD/build:/build-container-installer/build" \
  -e VERSION="$VERSION" \
  -e IMAGE_REPO=ghcr.io/jedace07 \
  -e IMAGE_NAME="$IMAGE_NAME" \
  -e IMAGE_TAG=latest \
  -e VARIANT=Server \
  -e FLATPAK_REMOTE_NAME=flathub \
  -e FLATPAK_REMOTE_URL=https://flathub.org/repo/flathub.flatpakrepo \
  -e FLATPAK_REMOTE_REFS_DIR=/github/workspace/flatpak_refs \
  ghcr.io/jasonn3/build-container-installer:latest
```

The ISO is written to `build/deploy.iso`.
