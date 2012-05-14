#!/bin/bash

# plesae do not edit test without talking to the test admin
# this could be replaced by a system wide script on bamboo later
vagrant sandbox rollback 2>> /tmp/vagrant.log

#no sandbox off for now, takes too long, should be "destroy and up" in a nightly/weekly cron or something
#vagrant sandbox off
vagrant halt
