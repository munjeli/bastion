# Encoding: UTF-8
#
# rubocop:disable SingleSpaceBeforeFirstArg
name             'bastion'
maintainer       'Jonathan Hartman'
maintainer_email 'jonathan.hartman@socrata.com'
license          'apache2'
description      'Configures a node to be a bastion host'
long_description 'Configures a node to be a bastion host'
version          '0.0.1'

supports         'ubuntu'

depends          'apt', '~> 2.0'
depends          'firewall', '~> 1.1.0' # TODO: firewall 1.2+ requires Chef 12+
depends          'chrome', '~> 1.0'
depends          'firefox', '~> 2.0'
# rubocop:enable SingleSpaceBeforeFirstArg
