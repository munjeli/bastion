# Encoding: UTF-8

service 'rsyslog' do
  start_command 'service rsyslog start'
  action :start
end

include_recipe 'bastion'
