# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  (1..3).each do |n|
    config.vm.define "node#{n}" do |node|
      node.vm.hostname = "node#{n}"
      node.vm.box = 'puppetlabs-ubuntu-12.04'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box'
      node.vm.network :private_network, ip: "192.168.42.1#{n}"
      node.vm.provision 'shell', path: 'init_node.sh'
      node.vm.provision 'shell', inline: "su ceph -c 'mkdir /tmp/osd#{n - 2}'" if n > 1
    end
  end

  config.vm.define 'deploy' do |deploy|
    deploy.vm.hostname = 'deploy'
    deploy.vm.box = 'puppetlabs-ubuntu-12.04'
    deploy.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box'
    deploy.vm.network :private_network, ip: '192.168.42.10'
    deploy.vm.provision 'shell', path: 'init_deploy.sh'
#    deploy.vm.box_url = 'http://files.vagrantup.com/precise64.box'
#    deploy.vm.network 'forwarded_port', guest: 80, host: 8080
  end

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  # config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []
#
#  config.vm.provision :chef_solo do |chef|
#    chef.json = {
#      :mysql => {
#        :server_root_password => 'rootpass',
#        :server_debian_password => 'debpass',
#        :server_repl_password => 'replpass'
#      }
#    }
#
#    chef.run_list = [
##        'recipe[ceph::default]'
#    ]
#  end
end
