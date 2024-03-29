# Encoding: UTF-8
#
# rubocop:disable SingleSpaceBeforeFirstArg
name             'bastion'
maintainer       'Jonathan Hartman'
maintainer_email 'jonathan.hartman@socrata.com'
license          'apache2'
description      'Configures a node to be a bastion host'
long_description 'Configures a node to be a bastion host'
version          '1.0.1'

supports         'ubuntu'

depends          'apt', '~> 2.0'
depends          'firewall', '~> 1.1.0' # TODO: firewall 1.2+ requires Chef 12+
depends          'x2go-server', '~> 0.1'
depends          'snoopy', '~> 1.0'
depends          'java',   '~> 1.35'
# rubocop:enable SingleSpaceBeforeFirstArg
