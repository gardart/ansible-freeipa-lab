# FreeIPA identity management (IDM) with Active Directory LAB

## LAB Overview

### Domains

| OS | Realm | Domain | Netbios Name | IP |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Windows Server 2019 | AD.TEST | ad.test | AD | 192.168.68.10 |
| Centos 8 | IPA.AD.TEST| ipa.ad.test | IPA | Freeipa Server 192.168.68.11 |

### Servers

| ROLE | OS | FQDN | IP |
| ------------- | ------------- | ------------- | ------------- |
| Domain Controller | Server 2019 | dc1.ad.test | 192.168.68.10 |
| IPA Server | Centos 8 | ipa.idm.ad.test | 192.168.68.11 |

### Users

| User | Domain | Role | Password |
| ------------- | ------------- | ------------- | ------------- |
| administrator | ad.test | Administrator | IDMpass1. |
| admin | idm.ad.test | Administrator | IDMpass1. |
| jon | ad.test | Administrator | J0nP4ssw0rd |

## Prerequirements
There are two Vagrant files to setup this LAB, one for Active Directory domain and another for FreeIPA domain.
To use the vagrant files, you will need to have done the following:

  1. Download and Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  2. Download and Install [Vagrant](https://www.vagrantup.com/downloads.html)
  3. Install [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)
  4. Run the following command to install the necessary Ansible roles for this profile: 
    `$ ansible-galaxy install -r requirements.yml`
  5. Install WinRM module for Ansible deployment on Windows and Vagrant package
    `$ pip install pywinrm python-vagrant`

### Setting up your hosts file

You need to modify your host machine's hosts file (Mac/Linux: `/etc/hosts`; Windows: `%systemroot%\system32\drivers\etc\hosts`), adding the line below:

     192.168.68.10  dc1.ad.test
     192.168.68.11  ipa.idm.ad.test

## Setup

### Clone this repo
```shell
git clone https://github.com/gardart/ansible-freeipa-lab.git
cd ansible-freeipa-lab
```

### Create Active Directory server with Vagrant and Ansible provisioner
```shell
cd provisioning/ad
vagrant up
```

### Create FreeIPA server with Vagrant and Ansible provisioner
```shell
cd provisioning/ipaserver
vagrant up
```

Browse to https://ipa.idm.ad.test/ipa/ui and login with user admin and password IDMpass1.