Bastion Cookbook
================
[![Cookbook Version](https://img.shields.io/cookbook/v/bastion.svg)][cookbook]
[![Build Status](https://img.shields.io/travis/socrata-cookbooks/chef-bastion.svg)][travis]
[![Code Climate](https://img.shields.io/codeclimate/github/socrata-cookbooks/chef-bastion.svg)][codeclimate]
[![Coverage Status](https://img.shields.io/coveralls/socrata-cookbooks/chef-bastion.svg)][coveralls]

[cookbook]: https://supermarket.chef.io/cookbooks/bastion
[travis]: https://travis-ci.org/socrata-cookbooks/chef-bastion
[codeclimate]: https://codeclimate.com/github/socrata-cookbooks/chef-bastion
[coveralls]: https://coveralls.io/r/socrata-cookbooks/chef-bastion

A Chef cookbook for configuring a server to be used as a bastion host for
remote access to and administration of an otherwise walled-off network.

Requirements
============

This cookbook is written to hopefully work on, or be expandable to, other
distros, but is currently only tested against Ubuntu Linux.

Some of the dependencies are pinned to older versions in order to maintain
compatibility--for now--with Chef 11.

Usage
=====

Override any included attributes as needed and add `bastion` to your run_list.

Recipes
=======

***default***

Refreshes the APT cache and configures the firewall and remote desktop (below).

***firewall***

If the firewall enabled attribute is set to true (the default), enables the
system firewall and pokes holes in it for SSH (port 22) from an
attribute-specified set of trusted networks.

If the firewall is not set to enabled, it disables it.

***remote_desktop***

Installs X2go, Google Chrome, and Firefox.

Attributes
==========

***default***

    default['bastion']['firewall']['enabled'] = true

Whether or not the system firewall should be enabled. This can be overridden to
false if, for example, port access is instead being handled solely in your
cloud provider's security configuration.

    default['bastion']['firewall']['trusted_networks'] = %w(
      10.0.0.0/8
      172.16.0.0/12
      192.168.0.0/16
    )

The set of CIDR ranges to allow access from in the system firewall.

Contributing
============

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add tests for the new feature; ensure they pass (`rake`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

License & Authors
=================
- Author: Jonathan Hartman <jonathan.hartman@socrata.com>

Copyright 2015 Socrata, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
