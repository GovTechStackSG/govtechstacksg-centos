#!/bin/bash

sudo yum group install 'Development Tools'
sudo yum install redhat-lsb kernel-abi-whitelists
sudo yum install kernel-devel-$(uname -r)
mkdir -p ${HOME}/rpmbuild/{BUILD,RPMS,SPECS,SOURCES,SRPMS}
echo -e "%_topdir ${HOME}/rpmbuild\n%dist .el$(lsb_release -s -r|cut -d"." -f1).local" >> ~/.rpmmacros
curl -sSLj -o ${HOME}/wl-kmod-6_30_223_271-5.el7.elrepo.nosrc.rpm http://elrepo.org/linux/elrepo/el7/SRPMS/wl-kmod-6_30_223_271-5.el7.elrepo.nosrc.rpm
curl -ssLj -o ${HOME}/rpmbuild/SOURCES/hybrid-v35_64-nodebug-pcoem-6_30_223_271.tar.gz https://docs.broadcom.com/docs-and-downloads/docs/linux_sta/hybrid-v35_64-nodebug-pcoem-6_30_223_271.tar.gz

rpmbuild --rebuild --define 'packager samloh84' ~/wl-kmod-6_30_223_271-5.el7.elrepo.nosrc.rpm
mv ${HOME}/rpmbuild/RPMS/x86_64/kmod-wl*rpm ${HOME}/
rm -rf ${HOME}/rpmbuild
sudo yum remove -y \*ndiswrapper\*
sudo yum --nogpgcheck localinstall -y ${HOME}/kmod-wl*rpm
sudo modprobe wl
