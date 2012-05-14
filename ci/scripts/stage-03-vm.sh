vagrant up
vagrant provision
vagrant sandbox on
vagrant ssh -c "bash /vagrant/ci/scripts/stage-03a-within-vm.sh"
vagrant rollback
vagrant sandbox off
vagrant halt
