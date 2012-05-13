
exec { "apt-get-update":
    command => "/usr/bin/apt-get update",
    refreshonly => true,
}

Package {
    ensure => installed,
    require => Exec["apt-get-update"]
}

class test-server inherits phpunit {
    group { "puppet":
        ensure => "present",
    }

    file { "swiss.list":
        path => "/etc/apt/sources.list",
        ensure => file,
        owner => "root",
        group => "root",
        content => "deb http://mirror.switch.ch/ftp/mirror/debian/ squeeze main non-free\ndeb http://security.debian.org/ squeeze/updates main non-free\ndeb http://mirror.switch.ch/ftp/mirror/debian/ squeeze-updates main non-free\n",

        notify => Exec["apt-get-update"],
    }


    $phppackages=["php5-cli","php5-common","php5-gd","php5-curl","php-pear"]

    package {$phppackages:
        ensure => latest,
    }

    package { "php5-suhosin": ensure => purged,}

}

class phpunit
{

    exec {"install-phpunit":
        command => "/bin/bash /vagrant/ci/vagrant/scripts/install_phpunit.sh",
        creates => "/usr/share/php/PHPUnit/Autoload.php",
        require =>  Package["php5-cli"],

    }

}
include test-server