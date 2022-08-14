# dotfiles

Configuration files.


## Setup

```console
git clone https://github.com/mopp/dotfiles.git
./dotfiles/install
```

## Note

- [one-dark/iterm-one-dark-theme: One Dark theme for iTerm2.](https://github.com/one-dark/iterm-one-dark-theme)


# Arch Linux installation note

基本的には次の2つを参照する

- [インストールガイド - ArchWiki](https://wiki.archlinux.jp/index.php/%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%82%AC%E3%82%A4%E3%83%89)
- [一般的な推奨事項 - ArchWiki](https://wiki.archlinux.jp/index.php/%E4%B8%80%E8%88%AC%E7%9A%84%E3%81%AA%E6%8E%A8%E5%A5%A8%E4%BA%8B%E9%A0%85)

## インストールしておくもの

```console
pacstrap /mnt base-devel linux linux-firmware
```

```console
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

- Terminal tools
  - git
  - github-cli
  - vim
  - zsh
  - zsh-completions
  - sudo
  - words
- Window environment
  - i3-wm
  - i3status
  - dmenu
  - xorg-xinit
  - fcitx5-im
  - fcitx5-mozc
  - feh
  - evince
  - geeqie
- Fonts
  - ttf-cica
  - ttf-mplus
  - ttf-rounded-mplus
- Others
  - clang
  - cmake
  - inetutils
  - intel-ucode
  - nvidia
  - rustup
  - unzip

[Jguer/yay: Yet another Yogurt - An AUR Helper written in Go](https://github.com/Jguer/yay) の設定

## ブートローダの設定

systemd のものを使う

- [systemd-boot - ArchWiki](https://wiki.archlinux.jp/index.php/Systemd-boot)

```
# /boot/loader/loader.conf
timeout 3
console-mode max
editor no

# /boot/loader/entries/arch.conf
title Arch Linux
linux vmlinuz-linux
initrd intel-ucode.img
initrd initramfs-linux.img
options root=UUID=REPLACE_ME rw nvidia_drm.modeset=1
```

## ネットワークの設定

systemd のものを使う

- [systemd-networkd - ArchWiki](https://wiki.archlinux.jp/index.php/Systemd-networkd)
- [systemd-resolved - ArchWiki](https://wiki.archlinux.jp/index.php/Systemd-resolved)

`/etc/systemd/network/20-wired.network` を次のように設定

```console
[Match]
Name=enp0s31f6

[Network]
DHCP=yes
```

```console
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service
```

## ユーザの追加

```console
useradd -m -g users -s /usr/bin/zsh mopp
passwd mopp
```

## Windows とデュアルブートする際の時刻の設定

Windows はハードウェアクロックを localtime として扱うので
Arch も同様に設定する
日本に夏時間はないので問題にはならないはず

```console
timedatectl set-local-rtc true
```

詳細は [時刻 - ArchWiki](https://wiki.archlinux.jp/index.php/%E6%99%82%E5%88%BB#Windows_.E3.81.A7_UTC_.E3.82.92.E4.BD.BF.E3.81.86) を参照
