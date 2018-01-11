# Install
install
text
reboot
url --url="ftp://yourdomain/pxeboot"
logging level=info

# Additionanl repos during install
repo --name=base --baseurl=ftp://yourdomain/centos/7/os/x86_64
repo --name=extras --baseurl=ftp://yourdomain/centos/7/extras/x86_64

# EULA sigh
eula --agreed

# Localization
keyboard us
lang en_US
timezone America/Vancouver --isUtc --ntpservers=yourdomain

# System features
firewall --disabled
selinux --disabled

# Auth
auth useshadow passalgo=sha512
rootpw --iscrypted #@!$#@!$#@!$#@!$#@!$#@!$#@!

# Network information
#network  --bootproto=dhcp --device=ens160 --ipv6=auto --activate

# System bootloader configuration
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=nvme0n1

# Partition clearing information
ignoredisk --only-use=nvme0n1
clearpart --all --initlabel --drives=nvme0n1

# Disk partitioning information
part /boot --fstype xfs --ondisk=nvme0n1 --size=500
part pv.01 --fstype lvmpv --ondisk=nvme0n1 --size=1 --grow

volgroup vg_main --pesize=4096 pv.01

logvol / --fstype xfs --vgname=vg_main --name=lv_root --size=1 --grow
logvol swap  --fstype swap --vgname=vg_main --name=swap --recommended

# Packages
%packages
@^minimal
@core
chrony
kexec-tools

%end


%addon com_redhat_kdump --enable --reserve-mb='auto'
%end

%post
curl ftp://yourdomain/config/CentOS7-init.sh -o /root/CentOS7-init.sh
chmod 700 /root/CentOS7-init.sh
%end


