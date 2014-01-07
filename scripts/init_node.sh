#!/bin/bash

sudo useradd -s /bin/bash -m ceph
echo "ceph:ceph"|sudo chpasswd

echo "ceph ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ceph
sudo chmod 0440 /etc/sudoers.d/ceph

sudo cat >> /etc/hosts <<EOF

192.168.42.10   deploy
192.168.42.11   node1
192.168.42.12   node2
192.168.42.13   node3
EOF
