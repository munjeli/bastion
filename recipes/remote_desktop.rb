# Encoding: UTF-8
#
# Cookbook Name:: bastion
# Recipe:: remote_desktop
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

%w(xorg fluxbox dbus-x11).each { |p| package p }

case node['bastion']['remote_desktop']['method'].to_sym
when :x11
  node.set['sshd']['sshd_config']['X11Forwarding'] = 'yes'
  node.set['sshd']['sshd_config']['X11UseLocalhost'] = 'yes'
  include_recipe 'sshd'
when :rdp
  include_recipe 'xrdp'
else
  fail(Chef::Exceptions::ValidationFailed,
       "`node['bastion']['remote_desktop']['method']` must be one of " \
       '`:rdp or `:x11`')
end

include_recipe 'chrome'
package 'firefox'
