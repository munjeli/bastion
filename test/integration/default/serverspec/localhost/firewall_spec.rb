# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::firewall' do
  describe iptables do
    it 'accepts SSH from private networks' do
      %w(10.0.0.0/8 172.16.0.0/12 192.168.0.0/16).each do |n|
        expected = "-A.* -s #{n} -p tcp -m tcp --dport 22 -j ACCEPT"
        expect(subject).to have_rule(expected)
      end
    end
  end
end
