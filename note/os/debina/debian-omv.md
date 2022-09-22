#Install OMV6 on Debian 11 (Bullseye)
> https://forum.openmediavault.org/index.php?thread/39490-install-omv6-on-debian-11-bullseye/
> https://ywnz.com/linuxjc/2704.html Debian Stretch系统中安装OMV


echo "deb http://packages.openmediavault.org/public shaitan main" >> /etc/apt/sources.list.d/openmediavault.list



export LANG=C.UTF-8
export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=none
apt-get install --yes gnupg
wget -O "/etc/apt/trusted.gpg.d/openmediavault-archive-keyring.asc" https://packages.openmediavault.org/public/archive.key
apt-key add "/etc/apt/trusted.gpg.d/openmediavault-archive-keyring.asc"
apt-get update
apt-get --yes --auto-remove --show-upgraded \
    --allow-downgrades --allow-change-held-packages \
    --no-install-recommends \
    --option DPkg::Options::="--force-confdef" \
    --option DPkg::Options::="--force-confold" \
    install openmediavault-keyring openmediavault

# Populate the database.
omv-confdbadm populate

# Display the login information.
cat /etc/issue

 
 

#之后就可以打开浏览器键入OMV所在的主机IP访问管理页面了。
username 'admin' and password 'openmediavault'.

