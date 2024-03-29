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

include_recipe 'x2go-server'

apt_repository 'google-chrome' do
  uri 'http://dl.google.com/linux/chrome/deb'
  distribution 'stable'
  components %w(main)
  key 'https://dl-ssl.google.com/linux/linux_signing_key.pub'
end

%w(xorg fluxbox dbus-x11 google-chrome-stable firefox).each { |p| package p }
