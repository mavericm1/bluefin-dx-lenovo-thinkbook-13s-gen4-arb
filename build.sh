#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install screen

#add libfprint-tod-goodix repo an override libfprint with libfprint-tod-goodix
curl -o /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:antiderivative:libfprint-tod-goodix-0.0.9.repo "https://copr.fedorainfracloud.org/coprs/antiderivative/libfprint-tod-goodix-0.0.9/repo/fedora-$(rpm -E %fedora)/antiderivative-libfprint-tod-goodix-0.0.9-fedora-$(rpm -E %fedora).repo"
rpm-ostree override replace --experimental --freeze --from repo=copr:copr.fedorainfracloud.org:antiderivative:libfprint-tod-goodix-0.0.9 libfprint-tod --reboot
rpm-ostree override remove libfprint
rpm-ostree install libfprint-tod-goodix

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
