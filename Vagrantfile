# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "govtechstacksg/centos"

  # Forwarded Ports
  config.vm.network "forwarded_port", guest: 22, host: 22
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8443, host: 8443
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "forwarded_port", guest: 443, host: 443

  # Configure and optimize according to your system specs
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.cpus = 2
    vb.memory = "4096"
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
    vb.customize ["modifyvm", :id, "--usbxhci", "on"]
  end


  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo yum install -y your-package-here
  # SHELL
end
