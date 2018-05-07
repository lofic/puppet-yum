# Provide various yum repos.
# Describe the repos and keys in hiera.

class yum(Hash $repos={}, Hash $keys={}) {

    if $::osfamily == 'RedHat' {

        file { ['/etc/pki', '/etc/pki/rpm-gpg'] :
            ensure => 'directory',
            owner  => 'root',
            group  => 'root',
            mode   => '0755',
        }

        $rdefaults = {
            'enabled'  => 1,
            'gpgcheck' => 1,
        }

        $repos.each |$r, $rp| { yumrepo { $r: * => $rdefaults + $rp} }

        $fdefaults = {
            owner     => 'root',
            group     => 'root',
            mode      => '0644',
            show_diff => false,
        }

        # create_resources('file', $keys, $fdefaults)
        $keys.each |$k, $kp| { file { $k: * => $fdefaults + $kp } }

    }

}

