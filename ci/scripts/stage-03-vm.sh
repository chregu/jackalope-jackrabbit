vagrant up
vagrant provision
vagrant ssh -c "cp /vagrant/ci/build/debs/jackalope-jackrabbit_0.9.deb . && sudo dpkg -i jackalope-jackrabbit_0.9.deb"
vagrant halt