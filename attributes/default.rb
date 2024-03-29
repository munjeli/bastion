# Encoding: UTF-8
#
# Cookbook Name:: bastion
# Attributes:: default
#
# Copyright 2015 Socrata, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['java']['jdk_version'] = 8
default['java']['install_flavor'] = 'oracle'
default['java']['oracle']['accept_oracle_download_terms'] = true

default['snoopy']['config']['filter_chain'] = 'only_tty:'

default['bastion']['firewall']['enabled'] = true
default['bastion']['firewall']['trusted_networks'] = %w(
  10.0.0.0/8
  172.16.0.0/12
  192.168.0.0/16
)
