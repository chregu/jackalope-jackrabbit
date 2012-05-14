#!/bin/bash

# plesae do not edit test without talking to the test admin
# this could be replaced by a system wide script on bamboo later
vagrant sandbox rollback 2>> /tmp/vagrant.log
vagrant sandbox off
vagrant halt
