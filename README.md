# borealis &nbsp; [![bluebuild build badge](https://github.com/jedace07/borealis/actions/workflows/build.yml/badge.svg)](https://github.com/jedace07/borealis/actions/workflows/build.yml)

WIP COSMIC image built with BlueBuild. NOT FOR PRODUCTION USE

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.
> You should ONLY rebase from an existing Fedora COSMIC Atomic image as rebasing from other desktop environments may cause issues.

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

If build on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/how-to/generate-iso/#_top). 

NOTE: While building the ISO, you need to specify `-V server` to be able to make a user account on the ISO. This is important because, unlike Kinoite (the default) and Silverblue, COSMIC doesn't yet have an account creation process.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/jedace07/borealis
```
