# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  
 
  config.vm.box = "ubuntu-16.04"

  config.vm.box_check_update = false

  config.persistent_storage.enabled = true
  config.persistent_storage.location = "opt_zimbra.vdi"
  config.persistent_storage.filesystem = 'ext4'
  config.persistent_storage.mountpoint = '/opt/zimbra'

  config.vm.network "forwarded_port", guest: 443, host: 4430
  config.vm.network "forwarded_port", guest: 7071, host: 4439

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "4096"
  end
 
  # NO! this is already in ubuntu-16.04.box template, so should be 2x" 
  #config.vm.provision "shell", inline: <<-SHELL
  #    /vagrant/vagrant.sh
  #SHELL
end
