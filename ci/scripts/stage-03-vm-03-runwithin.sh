#!/bin/bash

#that whole jackrabbit stuff should go into puppet
pidfile=${TMPDIR:-/tmp}/jack.pid

cp /vagrant/ci/build/debs/jackalope-jackrabbit_0.9.deb .
dpkg -i jackalope-jackrabbit_0.9.deb

cd /var/www/jackalope-jackrabbit

#starting jackrabbit
./bin/jackrabbit.sh

#running tests
mkdir -p ci/build/test-reports
phpunit -c tests/phpunit.xml.dist --coverage-clover ci/build/test-reports/clover.xml --log-junit  ci/build/test-reports/phpunit.xml
rm -rf /vagrant/ci/build/test-reports
cp -r ci/build/test-reports /vagrant/ci/build/
id=$(cat $pidfile 2>/dev/null)
#kill jackrabbit, otherwise the ssh process doesn't return
echo "killing jackrabbit to finish the script"
kill $id
rm $pidfile

