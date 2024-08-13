#!/bin/bash

# Install Opera Stable
sudo rpm --import https://rpm.opera.com/rpmrepo.key
sudo tee /etc/yum.repos.d/opera.repo <<RPMREPO
[opera]
name=Opera packages
type=rpm-md
baseurl=https://rpm.opera.com/rpm
gpgcheck=1
gpgkey=https://rpm.opera.com/rpmrepo.key
enabled=1
RPMREPO

sudo dnf install opera-stable

# Install Neovim
echo "Installing Neovim..."
sudo dnf install -y neovim
# Add Neovim to bashrc
echo "Configuring Neovim as the default editor in .bashrc..."
# Function to append only if not present
function append_if_not_exists {
    local file=$1
    local text=$2
    grep -qxF "$text" "$file" || echo "$text" >> "$file"
}
# Set environment variables in .bashrc
append_if_not_exists ~/.bashrc 'export EDITOR="nvim"'
append_if_not_exists ~/.bashrc 'export VISUAL="nvim"'
# Create symlinks for vi and vim to point to nvim
echo "Creating symlinks for vi and vim to point to Neovim..."
sudo ln -sf /usr/bin/nvim /usr/bin/vim
sudo ln -sf /usr/bin/nvim /usr/bin/vi
# Source .bashrc to apply changes
echo "Sourcing .bashrc to apply changes..."
source ~/.bashrc
echo "Setup complete. Neovim is now the default editor."

# Installing RPM Fusion
echo "Installing the RPMFusion Repo !"
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Updating Group Core
echo "Updating the Group Core !"
sudo dnf groupupdate core -y

# Installing Multimedia Codecs - Vital for Firefox videos
echo "Installing the Multimedia Codecs !"
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y

# Installing the Sound and Video Codecs
echo "Installing the Sound And Video Codecs !"
sudo dnf groupupdate sound-and-video -y
 
# Installing the RPMFusion FREE Tainted packages
echo "Installing the RPMFusion FREE Tainted packages !"
sudo dnf install rpmfusion-free-release-tainted -y

# Installing the RPMFusion FREE Tainted packages
echo "Install the LIBDVD package !"
sudo dnf install libdvdcss  -y

# Installing the RPMFusion FREE Tainted packages
echo "Installing the RPMFusion NON-FREE Tainted packages !"
sudo dnf install rpmfusion-nonfree-release-tainted -y

# Installing the RPMFusion FREE Tainted packages
echo "Install all the needed Firmware packages!"
sudo dnf install \*-firmware -y

# Update The System Before Installing the NVIDIA drivers
echo "Update The System Before Installing the NVIDIA drivers !!!"
sudo dnf update -y

# Install the NVIDIA Drivers Needed
echo "Install the NVIDIA Drivers Needed !!!"
sudo dnf install akmod-nvidia -y
echo "Installing the CUDA package needed for NVIDIA !"
sudo dnf install xorg-x11-drv-nvidia-cuda -y
echo "Installing The VULKAN package !"
sudo dnf install vulkan -y
sudo dnf install xorg-x11-drv-nvidia-cuda-libs -y

# Install FLATPAK
echo "Adding FLATPAK to your System !"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo "Installing the Gnome Extensions and Gnome Tweaks to your System !"

# Install Gnome Extensions and Tweaks
echo "Installing Gnome Extensions and Tweaks"
sudo dnf install gnome-extensions-app gnome-tweaks -y

# Installing SUBLIME
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf install sublime-text

# install VLC 
sudo dnf install vlc -y

# install GIT
sudo dnf install git -y

# install simplescreenrecorder 
sudo dnf install simplescreenrecorder -y

# Installing Wine
echo "Adding the WINEHQ Repo !!!"
sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/40/winehq.repo
echo "Installing the WINE package !"
sudo dnf install winehq-staging -y

# Installing lutris
echo "Installing the LUTRIS package!"
sudo dnf install steam lutris  -y

# Installing Steam
echo "Installing Steam "
#sudo dnf install steam -y

# Installing VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf install code


echo "===================================="
  
echo "You Are Ready And Fully LOADED :) ! "


