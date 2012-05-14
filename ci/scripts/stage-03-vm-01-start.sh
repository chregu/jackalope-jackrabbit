# plesae do not edit test without talking to the test admin
# this could be replaced by a system wide script on bamboo later
vagrant up
vagrant provision
vagrant sandbox on 2> /tmp/vagrant.log
