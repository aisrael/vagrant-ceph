# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  (1..3).each do |n|
    config.vm.define "node#{n}" do |node|
      node.vm.hostname = "node#{n}"
      node.vm.box = 'puppetlabs-ubuntu-12.04'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box'
      node.vm.network :private_network, ip: "192.168.42.1#{n}"
      node.vm.provision 'shell', path: 'scripts/init_node.sh'
      node.vm.provision 'shell', inline: "su ceph -c 'mkdir -p /var/tmp/osd#{n - 2}'" if n > 1
    end
  end

  config.vm.define 'deploy' do |deploy|
    deploy.vm.hostname = 'deploy'
    deploy.vm.box = 'puppetlabs-ubuntu-12.04'
    deploy.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box'
    deploy.vm.network :private_network, ip: '192.168.42.10'
    deploy.vm.provision 'shell', path: 'scripts/init_deploy.sh'
  end

end
