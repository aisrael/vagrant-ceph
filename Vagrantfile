# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  config.vm.define 'deploy' do |deploy|
    deploy.vm.hostname = 'deploy'
    deploy.vm.box = 'ubuntu-12.04-server-amd64-vbox-4.3.8'
#    deploy.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box'
    deploy.vm.network :private_network, ip: '192.168.42.10'
    deploy.vm.network 'forwarded_port', guest: 5000, host: 5000

    deploy.vm.provision 'ansible' do |ansible|
      ansible.host_key_checking = false
      ansible.playbook = 'ansible/playbook.yml'
      ansible.limit = 'deploy'
    end

  end

  (1..3).each do |n|
    config.vm.define "node#{n}" do |node|
      node.vm.hostname = "node#{n}"
      node.vm.box = 'ubuntu-12.04-server-amd64-vbox-4.3.8'
#      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box'
      node.vm.network :private_network, ip: "192.168.42.1#{n}"

      node.vm.provision 'ansible' do |ansible|
        ansible.host_key_checking = false
        ansible.playbook = 'ansible/playbook.yml'
        ansible.limit = node.vm.hostname
      end
    end
  end

  config.ssh.forward_agent = true

end
