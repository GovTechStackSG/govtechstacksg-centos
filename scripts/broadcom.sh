#!/bin/bash

yum install -y kernel-headers kernel-devel gcc
mkdir -p /usr/local/src/hybrid-wl
cd /usr/local/src/hybrid-wl


curl -ssLj -o /tmp/hybrid-v35_64-nodebug-pcoem-6_30_223_271.tar.gz https://docs.broadcom.com/docs-and-downloads/docs/linux_sta/hybrid-v35_64-nodebug-pcoem-6_30_223_271.tar.gz
tar -xvzf /tmp/hybrid-v35_64-nodebug-pcoem-6_30_223_271.tar.gz
chown -R vagrant:vagrant /usr/local/src/hybrid-wl

cd /usr/local/src/hybrid-wl

curl -ssLj "https://wiki.centos.org/HowTos/Laptops/Wireless/Broadcom?action=AttachFile&do=get&target=wl-kmod-fix-ioctl-handling.patch" | patch -p1
curl -ssLj "https://wiki.centos.org/HowTos/Laptops/Wireless/Broadcom?action=AttachFile&do=get&target=wl-kmod-kernel_4.7_IEEE80211_BAND_to_NL80211_BAND.patch" | patch -p1


sed -i 's/ >= KERNEL_VERSION(3, 11, 0)/ >= KERNEL_VERSION(3, 10, 0)/' src/wl/sys/wl_cfg80211_hybrid.c
sed -i 's/ >= KERNEL_VERSION(3, 15, 0)/ >= KERNEL_VERSION(3, 10, 0)/' src/wl/sys/wl_cfg80211_hybrid.c

sed -i 's/ < KERNEL_VERSION(3, 18, 0)/ < KERNEL_VERSION(3, 9, 0)/' src/wl/sys/wl_cfg80211_hybrid.c
sed -i 's/ >= KERNEL_VERSION(4, 0, 0)/ >= KERNEL_VERSION(3, 10, 0)/' src/wl/sys/wl_cfg80211_hybrid.c

sed -i 's/ < KERNEL_VERSION(4,2,0)/ < KERNEL_VERSION(3, 9, 0)/' src/wl/sys/wl_cfg80211_hybrid.c
sed -i 's/ >= KERNEL_VERSION(4, 7, 0)/ >= KERNEL_VERSION(3, 10, 0)/' src/wl/sys/wl_cfg80211_hybrid.c


rm -rf /tmp/hybrid-v35_64-nodebug-pcoem-6_30_223_271.tar.gz

cd /usr/local/src/hybrid-wl
make -C /lib/modules/`uname -r`/build/ M=`pwd`
strip --strip-debug wl.ko
cp -vi /usr/local/src/hybrid-wl/wl.ko /lib/modules/`uname -r`/extra/

depmod $(uname -r)
modprobe wl


cat <<- EOF | tee -a /etc/modprobe.d/blacklist.conf > /etc/null

blacklist bcm43xx
blacklist b43
blacklist b43legacy
blacklist bcma
blacklist brcmsmac
blacklist ssb
blacklist ndiswrapper

EOF



cat <<- EOF | tee -a /etc/sysconfig/modules/kmod-wl.modules > /etc/null

#!/bin/bash

for M in lib80211 cfg80211 wl; do
modprobe $M &>/dev/null
done

EOF