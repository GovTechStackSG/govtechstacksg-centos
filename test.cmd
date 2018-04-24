vagrant destroy --force

vagrant box remove govtechstacksg-centos
vagrant box add --name govtechstacksg-centos ./output/govtechstacksg-centos.box
vagrant init govtechstacksg-centos
vagrant up
