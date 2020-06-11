# multipass-k3s-travisci
multipass k3s kubernetes

Travis (.com)  branch:
[![Build Status](https://travis-ci.com/githubfoam/multipass-k3s-travisci.svg?branch=master)](https://travis-ci.com/githubfoam/multipass-k3s-travisci)  


AMD64 (one master + 6 nodes)
~~~~
$ sudo multipass exec node1 sudo kubectl get nodes

NAME    STATUS   ROLES    AGE     VERSION

node1   Ready    master   5m52s   v1.18.3+k3s1

node2   Ready    <none>   4m45s   v1.18.3+k3s1

node3   Ready    <none>   3m50s   v1.18.3+k3s1

node4   Ready    <none>   2m56s   v1.18.3+k3s1

node5   Ready    <none>   2m3s    v1.18.3+k3s1

node6   Ready    <none>   64s     v1.18.3+k3s1

node7   Ready    <none>   6s      v1.18.3+k3s1
~~~~

~~~~
Using libvirt in Multipass
https://multipass.run/docs/using-libvirt

Installing Multipass for Windows
https://multipass.run/docs/installing-on-windows

Installing Multipass on macOS
https://multipass.run/docs/installing-on-macos

Installing Multipass on Linux
https://multipass.run/docs/installing-on-linux
Using VirtualBox in Multipass on macOS

https://multipass.run/docs/using-virtualbox-in-multipass-macos

Cloud-init is the industry standard multi-distribution method for cross-platform cloud instance initialization. It is supported across all major public cloud providers, provisioning systems for private cloud infrastructure, and bare-metal installations.
https://cloudinit.readthedocs.io/en/latest/

Kubernetes storage
https://openebs.io

OpenZFS on Linux and FreeBSD
https://github.com/openzfs/zfs

Native ZFS on Linux
https://zfsonlinux.org/

https://k3s.io/

https://github.com/rancher/k3s

macOS Version
The default backend on macOS is hyperkit, wrapping Apple’s Hypervisor.framework
You need macOS Yosemite, version 10.10.3 or later installed on a 2010 or newer Mac
https://docs.travis-ci.com/user/reference/osx/#macos-version
~~~~
