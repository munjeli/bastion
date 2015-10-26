# Encoding: UTF-8
#
# Cookbook Name:: bastion
# Recipe:: logging
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

include_recipe 'snoopy'

# TODO: Ideally, this would be handled by a new or updated auditd cookbook,
# but the current one writes one single template rather than separate .d files
package 'auditd'

file '/etc/audit/rules.d/audit.rules' do
  extend Chef::Mixin::ShellOut
  # Use the STIG ruleset, but replace the RHEL-specific sysconfig path
  content lazy {
    shell_out!(
      'zcat /usr/share/doc/auditd/examples/stig.rules.gz ' \
      '| sed "s/\\/etc\\/sysconfig\\/network/\\/etc\\/network/g"'
    ).stdout
  }
  notifies :run, 'execute[augenrules]'
end

service 'auditd' do
  action [:enable, :start]
end

execute 'augenrules' do
  action :nothing
  notifies :restart, 'service[auditd]'
end
