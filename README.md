# FreeIPA identity management (IDM) with Active Directory LAB

## Domains
| OS | Realm | Domain | Netbios Name | IP |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Windows Server 2019 | AD.TEST | ad.test | AD | 192.168.68.10 |
| Centos 8 | IPA.AD.TEST| ipa.ad.test | IPA | Freeipa Server 192.168.68.11 |

## Servers

| ROLE | OS | FQDN | IP |
| ------------- | ------------- | ------------- | ------------- |
| Domain Controller | Server 2019 | dc1.ad.test | 192.168.68.10 |
| IPA Server | Centos 8 | ipa.idm.ad.test | 192.168.68.11 |

## Users

| User | Domain | Role | Password |
| ------------- | ------------- | ------------- | ------------- |
| administrator | ad.test | Administrator | IDMpass1. |
| admin | idm.ad.test | Administrator | IDMpass1. |
| jon | ad.test | Administrator | J0nP4ssw0rd |

# Setup

```shell
git clone https://github.com/gardart/ansible-freeipa-lab.git
cd ansible-freeipa-lab
```

```shell
cd provisioning/ipaserver
vagrant up
```

```shell
cd provisioning/ad
vagrant up
```