# borealis &nbsp; [![bluebuild build badge](https://github.com/jedace07/borealis/actions/workflows/build.yml/badge.svg)](https://github.com/jedace07/borealis/actions/workflows/build.yml)

See the [BlueBuild docs](https://blue-build.org/how-to/setup/) for quick setup instructions for setting up your own repository based on this template.

After setup, it is recommended you update this README to describe your custom image.

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/jedace07/borealis:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/jedace07/borealis:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## ISO

Build the ISO with the `Server` installer variant, which asks for a user account during installation. The ISO builder also bundles the default Flathub apps from `flatpak_refs/`, so they are installed as part of the OS deployment instead of being downloaded on first boot. Set `IMAGE_NAME=borealis-nvidia` to build the NVIDIA image instead.

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

The resulting ISO is written to `build/deploy.iso`. Generate it from a Fedora Atomic host with Podman and network access. These ISOs are too large to distribute through GitHub's free artifact storage, so public projects need another hosting option.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/jedace07/borealis
```
