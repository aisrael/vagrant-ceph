#!/bin/bash

sudo apt-get update
sudo apt-get install -y expect

sudo useradd -s /bin/bash -m ceph
echo "ceph:ceph"|sudo chpasswd

echo "ceph ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ceph
sudo chmod 0440 /etc/sudoers.d/ceph

sudo cat >> /etc/hosts <<EOF

192.168.42.11   node1
192.168.42.12   node2
192.168.42.13   node3
EOF

wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -
echo deb http://ceph.com/debian-emperor/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
sudo apt-get update
sudo apt-get install -y ceph-deploy

su ceph <<EOF
mkdir -p /home/ceph/.ssh
ssh-keygen -N "" -f /home/ceph/.ssh/id_rsa
expect -c 'spawn ssh-copy-id ceph@node1; expect "Are you sure you want to continue connecting (yes/no)?"; send -- "yes\r"; expect "password:"; send -- "ceph\r"; expect eof'
expect -c 'spawn ssh-copy-id ceph@node2; expect "Are you sure you want to continue connecting (yes/no)?"; send -- "yes\r"; expect "password:"; send -- "ceph\r"; expect eof'
expect -c 'spawn ssh-copy-id ceph@node3; expect "Are you sure you want to continue connecting (yes/no)?"; send -- "yes\r"; expect "password:"; send -- "ceph\r"; expect eof'
EOF

su ceph -c 'cat >> /home/ceph/.ssh/config <<EOF
Host node1
   Hostname node1
   User ceph

Host node2
   Hostname node2
   User ceph

Host node3
   Hostname node3
   User ceph
EOF'

# See http://ceph.com/docs/master/start/quick-ceph-deploy/
su ceph <<EOF
mkdir -p /home/ceph/my-cluster
cd /home/ceph/my-cluster
ceph-deploy new node1
ceph-deploy install deploy node1 node2 node3
ceph-deploy mon create node1
ceph-deploy gatherkeys node1
ceph-deploy osd prepare node2:/var/tmp/osd0 node3:/var/tmp/osd1
ceph-deploy osd activate node2:/var/tmp/osd0 node3:/var/tmp/osd1
ceph-deploy admin deploy node1 node2 node3
EOF
