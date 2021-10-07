# FreeIPA identity management (IDM) with Active Directory trust
https://www.freeipa.org/page/Demo

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
| IPA Replica | Centos 8 | rep.idm.ad.test | 192.168.68.12 |
| IPA Client | Centos 8 | cli.idm.ad.test | 192.168.68.13 |

### Users

| User | Domain | Role | Password |
| ------------- | ------------- | ------------- | ------------- |
| administrator | ad.test | Administrator | IDMpass1. |
| admin | idm.ad.test | Administrator | IDMpass1. |
| jon | ad.test | Administrator | J0nP4ssw0rd |

## Prerequirements
This LAB is built with Ansible, Vagrant and Virtualbox. There are Vagrant files inside the provisioning directory.
To use the vagrant files, you will need to have done the following:

  1. Download and Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
  2. Download and Install [Vagrant](https://www.vagrantup.com/downloads.html)
  3. Install [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)
  4. Run the following command to install the necessary Ansible roles for this profile: 
    `$ ansible-galaxy collection install -r requirements.yml`
  5. Install WinRM module for Ansible deployment on Windows and Vagrant package
    `$ pip install pywinrm python-vagrant`

### Setting up your hosts file

You need to modify your host machine's hosts file (Mac/Linux: `/etc/hosts`; Windows: `%systemroot%\system32\drivers\etc\hosts`), adding the line below:

     192.168.68.10  dc1.ad.test
     192.168.68.11  ipa.idm.ad.test
     192.168.68.12  rep.idm.ad.test
     192.168.68.13  cli.idm.ad.test

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

Viewing the status of IdM services
```shell
$ ipactl status
Directory Service: RUNNING
krb5kdc Service: RUNNING
kadmin Service: RUNNING
named Service: RUNNING
httpd Service: RUNNING
ipa-custodia Service: RUNNING
pki-tomcatd Service: RUNNING
smb Service: RUNNING
winbind Service: RUNNING
ipa-otpd Service: RUNNING
ipa-dnskeysyncd Service: RUNNING
ipa: INFO: The ipactl command was successful
```

### Create FreeIPA replicas with Vagrant and Ansible provisioner
To create more than one replica, change the ```numberof_ipa_replicas``` variable in default.config.yml, the default value is 1.
```shell
cd provisioning/ipareplica
vagrant up
```

### Create FreeIPA client with Vagrant and Ansible provisioner
To create more than one client, change the ```numberof_ipa_clients``` variable in default.config.yml, the default value is 1.
```shell
cd provisioning/ipaclient
vagrant up
```

## Connect FreeIPA with Active Directory (one-way trust)
https://www.freeipa.org/page/Active_Directory_trust_setup#If_IPA_is_subdomain_of_AD

Configure netbios name for idm.ad.test.
Support for trusted domain is enabled setting a netbios name for linux domain. 
This is a prerequisite because active directory expects from remote side a netbios name.
```shell
ipa-adtrust-install
```

Configure DNS forwarder on freeipa server. 
```shell
ipa dnsforwardzone-add ad.test --forwarder=192.168.68.10 --forward-policy=only
```

Test records
```shell
dig SRV _ldap._tcp.ad.test
dig SRV _kerberos._tcp.ad.test
```

The SRV query is forwarded to AD and it’s returned the reference of kerberos (port 88) and ldap services (port 389). 
In this way the sssd client is able to know how to contact the active directory services

On the Windows Active Directory server, we need the same thing:

```shell
dnscmd 127.0.0.1 /RecordAdd ad.test ipa.idm.ad.test. A 192.168.68.11
dnscmd 127.0.0.1 /RecordAdd ad.test idm.ad.test. NS ipa.idm.ad.test
```

Test
```shell
nslookup -type=SRV _ldap._tcp.ad.test
nslookup -type=SRV _ldap._tcp.idm.ad.test
nslookup -type=SRV _kerberos._tcp.idm.ad.test
```

## Debugging

### IPA health
https://github.com/freeipa/freeipa-healthcheck
```shell
ipa-healthcheck --output-type human
ipa-healthcheck --output-type human --failures-only
```

### SSSD Cache
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/linux_domain_identity_authentication_and_policy_guide/sssd-system-uids
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/deployment_guide/sssd-cache
If the administrator knows that a specific record (user, group, or netgroup) has been updated, then sss_cache can purge the records for that specific account and leave the rest of the cache intact: 
```shell
sss_cache -u jon@ad.test
id jon@ad.test
```

Most commonly, this is used to clear the cache and update all records: 
```shell
sss_cache -E
id jon@ad.test
```

Manually Deleting Cache Files
```shell
systemctl stop sssd; rm -rf /var/lib/sss/{mc,db}/* ; systemctl start sssd
```

### Viewing, starting and stopping the Identity Management services
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_identity_management/viewing-starting-and-stopping-the-ipa-server_configuring-and-managing-idm

### Debugging AD Trust
https://www.freeipa.org/page/Active_Directory_trust_setup#Debugging_trust

https://www.freeipa.org/page/Active_Directory_trust_setup#Allow_access_for_users_from_AD_domain_to_protected_resources

https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_authentication_and_authorization_in_rhel/understanding-sssd-and-its-benefits_configuring-authentication-and-authorization-in-rhel

## LE external certificates for httpd
```shell
ipa-cacert-manage install isrgrootx1.pem
ipa-cacert-manage install isrg-root-x2.pem
ipa-cacert-manage install lets-encrypt-e1.pem
ipa-cacert-manage install lets-encrypt-e2.pem
ipa-cacert-manage install lets-encrypt-r3.pem
ipa-cacert-manage install lets-encrypt-r4.pem

ipa-certupdate
ipa-server-certinstall -w example_com.key example_com.cer --pin="" --dirman-password=password
ipactl restart
curl --insecure -vvI https://example.com/ipa/ui/ 2>&1 | awk 'BEGIN { cert=0 } /* SSL connection/ { cert=1 } /*/ { if (cert) print }'
'''

## Issues
Disable DNSSEC validation
```
/etc/named/ipa-options-ext.conf
    dnssec-validation no;

systemctl restart named-pkcs11
```
Login failure with AD account when KDC is not found.
From /var/log/secure 
sshd[11566]: pam_sss(sshd:auth): received for user jon@ad.test: 6 (Permission denied)
Also from /var/log/messages
krb5_child[6962][6962]: Cannot find KDC for realm "AD.TEST"

Issue normally related to DNS lookup, check /etc/resolv.conf and if /etc/krb5.conf has dns_lookup_kdc = true
https://access.redhat.com/solutions/3242461

## Further reading
### Determining the appropriate number of replicas
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/planning_identity_management/index#determining-the-appropriate-number-of-replicas_planning-the-replica-topology

Set up at least two replicas in each data center
    A data center can be, for example, a main office or a geographical location. 
Set up a sufficient number of servers to serve your clients
    One Identity Management (IdM) server can provide services to 2000 - 3000 clients. This assumes the clients query the servers multiple times a day, but not, for example, every minute. If you expect more frequent queries, plan for more servers. 
Set up a sufficient number of Certificate Authority (CA) replicas
    Only replicas with the CA role installed can replicate certificate data. If you use the IdM CA, ensure your environment has at least two CA replicas with certificate replication agreements between them. 
Set up a maximum of 60 replicas in a single IdM domain
    Red Hat supports environments with up to 60 replicas. 
