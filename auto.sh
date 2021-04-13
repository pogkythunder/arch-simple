#!/bin/bash

# Fill these in
read -p "Enter your username: `echo $'\n> '`" user

`echo $'\n '`

read -sp "Enter your user password:  `echo $'\n> '`"  user_password

`echo $'\n '`

read -sp "Enter your root password:  `echo $'\n> '`"  root_password

`echo $'\n '`

read -p "Enter your timezone:  `echo $'\n> '`"  timezone

`echo $'\n '`

read -p "Kernel - type the full name: (linux/linux-hardened/linux-lts etc.)  `echo $'\n> '`" kernel

`echo $'\n '`

echo "Available environments: KDE, GNOME, DWM-CORE, DWM-MOST"

read -p "Choose DE/WM:  `echo $'\n> '`" installation

`echo $'\n '`

read -p "Would you like to install yay AUR helper?`echo $'\n> '`" yay

echo "Choose a few countries to search for the fastest mirror. Separate the countries by a comma, no spaces, no quotation marks. E.g Germany,Sweden,Belgium"

read -p `echo $'\n> '` countries

read -p "Continue? (y/n)" confirm

if [ $confirm = "n" ]
then
	exit 0
else
	continue
fi

# Remove system beep
rmmod pcspkr

# Create new partitions
fdisk /dev/sda << EEOF
g
n
1

+512M
t
1
n



w
EEOF
mkfs.fat -F32 /dev/sda1
y
mkfs.ext4 /dev/sda2
y
pacman -Syy

reflector --country $countries --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

mount /dev/sda2 /mnt
pacstrap /mnt base $kernel linux-firmware vim
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt <<-EOF
timedatectl set-timezone $timezone
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8
echo $user-pc > /etc/hostname
touch /etc/hosts
echo -e "127.0.0.1    localhost \n::1         localhost \n127.0.1.1    $user-pc" > /etc/hosts
passwd
$root_password
$root_password


pacman -S grub efibootmgr
Y
EOF

arch-chroot /mnt << EOF
mkdir /boot/efi

mount /dev/sda1 /boot/efi

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi

grub-mkconfig -o /boot/grub/grub.cfg

useradd -m $user
passwd $user
$user_password
$user_password
pacman -S sudo

EOF
arch-chroot /mnt << EOF
sed -i "80i $user ALL=(ALL) ALL" /etc/sudoers
EOF

if [ "$installation" == "DWM-MOST" ]
then
	arch-chroot /mnt <<-EOF
	pacman -S --noconfirm xorg xorg-xinit breeze breeze-gtk element-desktop feh keepassxc libnotify base-devel git gparted picom zathura pcmanfm networkmanager lxappearance wget xautolock devilspie vifm ntfs-3g dmenu


	EOF
elif [ "$installation" == "KDE" ]
then
	arch-chroot /mnt <<-EOF
	pacman -S --noconfirm xorg plasma dolphin konsole base-devel git


	EOF

elif [ "$installation" == "GNOME" ]
then
	arch-chroot /mnt <<-EOF
	pacman -S --noconfirm xorg xorg-xinit gnome konsole base-devel git wget ntfs-3g

	EOF

elif [ "$installation" == "DWM-CORE" ]
then
	arch-chroot /mnt <<-EOF
	pacman -S --noconfirm xorg xorg-xinit base-devel git wget networkmanager dmenu
	EOF
fi



if [ "$yay" == "y" ]
then
	arch-chroot /mnt <<-EOF
	cd /opt
	git clone https://aur.archlinux.org/yay.git
	chown -R $user:users ./yay
	cd yay
	runuser -u $user -- makepkg -si --noconfirm
	y




	EOF
fi

#arch-chroot /mnt <<-EOF
#run$user -u $user -- yay -S librewolf-bin cantarell-fonts nerd-fonts-liberation-mono noto-fonts adobe-source-code-pro-fonts qt5ct 
# These are needed to complete the "DWM-MOST" cofiguration but cannot be automatically installed.

#EOF

if [ "$installation" == "DWM-MOST" ] || [ "$installation" == "DWM-CORE" ]
then 
	arch-chroot /mnt <<-EOF
	cd /home/$user
	mkdir Programs
	mkdir Downloads
	EOF
fi

if [ "$installation" == "DWM-MOST" ]
then
	arch-chroot /mnt <<-EOF
	cd /home/$user/Programs
	wget https://github.com/pogkythunder/arch-simple/raw/main/dwm-6.2.tar.gz
	tar -xzvf dwm-6.2.tar.gz
	cd dwm-6.2
	make clean install
	cd /home/$user/Programs
	rm *.gz

	EOF

elif [ "$installation" = "DWM-CORE" ]
then
	arch-chroot /mnt <<-EOF
	cd /home/$user/Programs
	wget https://dl.suckless.org/dwm/dwm-6.2.tar.gz
	tar xzvf dwm-6.2.tar.gz
	cd dwm-6.2
	make clean install
	cd /home/$user/Programs
	rm *.gz
	EOF
fi


if [ "$installation" == "DWM-MOST" ] || [ "$installation" == "DWM-CORE" ]
then
	arch-chroot /mnt <<-EOF
	cd home/$user/Programs
	wget https://dl.suckless.org/st/st-0.8.4.tar.gz
	tar xzvf st-0.8.4.tar.gz
	cd st-0.8.4
	make clean install
	cd home/$user/Programs
	rm *.gz
	EOF
fi

if [ "$installation" == "DWM-MOST" ]
then
	arch-chroot /mnt <<-EOF
	cd home/$user/Programs
	wget https://github.com/dunst-project/dunst/archive/v1.6.1.tar.gz
	tar xzvf v1.6.1.tar.gz
	cd dunst-1.6.1
	rm config.h
	EOF
fi

if [ "$installation" == "DWM-MOST" ]
then
	arch-chroot /mnt <<-EOF
	cd /home/$user/Programs
	wget https://raw.githubusercontent.com/pogkythunder/arch-simple/main/dunstrc
	make clean install
	cd home/$user/Programs
	rm *.gz
	EOF

else
	break
fi

if [ "$installation" == "DWM-MOST" ]
then
	arch-chroot /mnt <<-EOF
	cd /home/$user/Programs/dunst-1.6.1
	wget https://github.com/pogkythunder/arch-simple/raw/main/config.h
	make clean install
	EOF
fi


if [ "$installation" == "DWM-MOST" ]
then
	arch-chroot /mnt <<-EOF
	cd home/$user/Programs
	wget https://dl.suckless.org/tools/slock-1.4.tar.gz
	tar xzvf slock-1.4.tar.gz
	cd slock-1.4
	sed -i 's/nobody/$user/g' config.h
	sed -i 's/nogroup/$user/g' config.h
	make clean install
	cd home/$user/Programs
	rm *.gz
	EOF

else
	break
fi

if [ "$installation" == "DWM-MOST" ]
then
	arch-chroot /mnt <<-EOF
	cd /home/$user
	wget https://raw.githubusercontent.com/pogkythunder/arch-simple/main/bash_profile 
	mv bash_profile .bash_profile
	EOF

else
	break
fi

if [ "$installation" == "DWM-MOST" ]
then
	arch-chroot /mnt <<-EOF
	cd /home/$user
	wget https://raw.githubusercontent.com/pogkythunder/arch-simple/main/bashrc
	mv bashrc .bashrc
	EOF

else
	break
fi

if [ "$installation" == "DWM-MOST" ]
then
	arch-chroot /mnt <<-EOF
	cd /home/$user
	wget https://raw.githubusercontent.com/pogkythunder/arch-simple/main/xinitrc
	mv xinitrc .xinitrc
	EOF

else
	break
fi

if [ "$installation" == "DWM-MOST" ]
then
	arch-chroot /mnt <<-EOF
	cd /home/$user
	wget https://raw.githubusercontent.com/pogkythunder/arch-simple/main/vimrc
	mv vimrc .vimrc
	EOF

else
	break
fi

if [ "$installation" == "DWM-MOST" ]
then
	arch-chroot /mnt <<-EOF
	cd /home/$user
	wget https://raw.githubusercontent.com/pogkythunder/arch-simple/main/environment
	mv environment /etc
	EOF

else
	break
fi

if [ "$installation" == "DWM-MOST" ]
then
	arch-chroot /mnt <<-EOF
	cd /home/$user/Downloads
	wget https://raw.githubusercontent.com/pogkythunder/arch-simple/main/wallpaper1.png
	EOF

else
	break
fi

arch-chroot /mnt << EOF
systemctl enable NetworkManager.service
EOF

if [ "$installation" == "KDE" ]
then
	arch-chroot /mnt <<-EOF
	systemctl enable sddm.service
	EOF
elif [ "$installation" == "GNOME" ]
then
	arch-chroot /mnt <<-EOF
	systemctl enable gdm.service
	EOF
fi

reboot now

