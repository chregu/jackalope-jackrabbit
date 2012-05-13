vagrant up
vagrant provision
vagrant ssh -c "cp /vagrant/ci/build/debs/jackalope-jackrabbit_0.9.deb . && sudo dpkg -i jackalope-jackrabbit_0.9.deb"
vagrant ssh -c "cd /var/www/jackalope-jackrabbit &&  sudo ./bin/jackrabbit.sh &&  sudo phpunit -c tests/phpunit.xml.dist"
vagrant halt