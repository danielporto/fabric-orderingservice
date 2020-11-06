# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "dporto/centos8dev"
  # config.vm.box_version = "0.0.1"
  # config.vm.box = "file:///home/dporto/boxes/centos8dev/gsd-centos-8.box"
  config.vm.box = "http://www.gsd.inesc-id.pt/~dporto/boxes/gsd-ubuntu-18.box"


  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network", :bridge => "en0"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true
  
    #   # customize the number of CPUs
    vb.cpus = 2
    #   # Customize the amount of memory on the VM:
    vb.memory = "8000"
    #vb.customize ["modifyvm", :id, "--cpuexecutioncap", "33"]
#    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
#    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
#    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
  #   dnf update --nobest
  #   dnf install tmux
    apt update
    apt install -y debconf-utils git-all build-essential python-pip python-dev curl libc6-dev-i386 autoconf software-properties-common zip unzip
    apt remove -y docker-compose
    # install java
    runuser -l vagrant -c 'curl -s "https://get.sdkman.io" | bash'
    runuser -l vagrant -c 'source /home/vagrant/.sdkman/bin/sdkman-init.sh && sdk install java 8.0.272-zulu && sdk install ant && sdk flush archives'
    
    # install go
    curl -O https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz  && tar -xvf go1.10.3.linux-amd64.tar.gz && mv go /usr/local  && rm go1.10.3.linux-amd64.tar.gz     
    #runuser -l vagrant -c 'mkdir -p /home/vagrant/go'
    run -l vagrant -c "echo 'export GOPATH=/usr/local/go' >> /home/vagrant/.profile"
    run -l vagrant -c "echo 'export PATH=\$GOPATH/bin:\$PATH' >> /home/vagrant/.profile"

    pip install --upgrade pip
    pip uninstall -y docker-compose
    curl -L "https://github.com/docker/compose/releases/download/1.27.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose

    # optimizations
    apt install zsh 
    runuser -l vagrant -c ' git clone https://github.com/danielporto/zsh-dotfiles.git /home/vagrant/.dotfiles'
    # runuser -l vagrant -c ' /home/vagrant/.dotfiles/install'

  SHELL
end
