### Lab setup
vagrant up

### Test
ansible-playbook -i inventory install-cluster.yml --check -v

### Deploy
ansible-playbook -i inventory install-cluster.yml -v