# Encoding: UTF-8
#
# Cookbook Name:: bastion
# Recipe:: firewall
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

if node['bastion']['firewall']['enabled']
  firewall 'default' do
    action :enable
  end

  Array(node['bastion']['firewall']['trusted_networks']).each do |network|
    firewall_rule "#{network} - ssh" do
      protocol :tcp
      port 22
      source network
      action :allow
    end
  end
else
  firewall 'default' do
    action :disable
  end
end
