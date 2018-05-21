# GovTechStack.sg Centos Training VM

This is a Packer script to build a Centos 7 Desktop image for use in GovTechStack.sg training sessions.

Pushed to vagrant cloud as govtechstacksg/centos


# Prerequisites

1. Please ensure that your laptop meets the following requirements:
	* Virtualization enabled in your BIOS Settings
	* At least 2 CPU, 4 GB of RAM and 10GB of disk space available for the Vagrant Virtual Machine
	
2. Download and Install the following software:
	* [Oracle VirtualBox 5.2.12](https://www.virtualbox.org/wiki/Downloads#VirtualBox5.2.12platformpackages)
	* [Oracle VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads#VirtualBox5.2.12OracleVMVirtualBoxExtensionPack)
	* [Vagrant 2.1.1](https://www.vagrantup.com/downloads.html)

3. Follow the steps below to download and start the Vagrant Virtual Machine 

# Running the Vagrant image

Copy the following text to a file named ```Vagrantfile```
```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "govtechstacksg/centos"

  # Forwarded Ports
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Configure and optimize according to your system specs
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.cpus = 2
    vb.memory = "4096"
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
  end


  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo yum install -y your-package-here
  # SHELL
end
```

Run the following commands:
```bash
vagrant destroy --force
vagrant box remove govtechstacksg/centos
vagrant up
```

As per Vagrant box conventions, the credentials to use the image are as follows:
```
Username: vagrant
Password: vagrant
```
