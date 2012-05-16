#!/bin/bash


cp /vagrant/ci/build/debs/jackalope-jackrabbit_0.9.deb .
dpkg -i jackalope-jackrabbit_0.9.deb

cd /var/www/jackalope-jackrabbit

#running tests
mkdir -p ci/build/test-reports
phpunit -c tests/phpunit.xml.dist --coverage-html ci/build/test-reports/html --coverage-clover ci/build/test-reports/clover.xml --log-junit  ci/build/test-reports/phpunit.xml
rm -rf /vagrant/ci/build/test-reports
cp -r ci/build/test-reports /vagrant/ci/build/

