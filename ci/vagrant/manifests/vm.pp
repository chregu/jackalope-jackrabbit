
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


    $phppackages=["php5-cli","php5-common","php5-gd","php5-curl","php-pear","php5-xdebug"]

    package {$phppackages:
        ensure => latest,
    }
      # Thanks to Java strange licensing
        file {"/var/cache/debconf/sun-java6-bin.preseed":
          ensure  => present,
          content => "sun-java6-bin   shared/accepted-sun-dlj-v1-1    boolean true",
        }

        package { "sun-java6-bin":
          ensure => present,
          responsefile => "/var/cache/debconf/sun-java6-bin.preseed",
          require => File["/var/cache/debconf/sun-java6-bin.preseed"],
          before => Package["sun-java6-jdk"],
        }


    package {"sun-java6-jdk": ensure => latest}

    package { "php5-suhosin": ensure => purged,}

    exec {"install-jackrabbit":
        command => "/bin/bash /vagrant/ci/vagrant/scripts/install_jackrabbit.sh",
        creates => "/var/lib/jackrabbit-standalone/bin/jack",
        require =>  Package["sun-java6-jdk"],

    }
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