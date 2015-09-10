# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::firewall' do
  let(:overrides) { nil }
  let(:runner) do
    ChefSpec::SoloRunner.new do |node|
      overrides && overrides.each { |k, v| node.set[k] = v }
    end
  end
  let(:chef_run) { runner.converge(described_recipe) }

  context 'all default attributes' do
    it 'enables the firewall' do
      expect(chef_run).to enable_firewall('default')
    end

    it 'opens SSH access to the trusted networks' do
      %w(10.0.0.0/8 172.16.0.0/12 192.168.0.0/16).each do |n|
        expect(chef_run).to allow_firewall_rule("#{n} - ssh")
          .with(protocol: :tcp, port: 22, source: n)
      end
    end

    it 'opens RDP access to the trusted networks' do
      %w(10.0.0.0/8 172.16.0.0/12 192.168.0.0/16).each do |n|
        expect(chef_run).to allow_firewall_rule("#{n} - rdp")
          .with(protocol: :tcp, port: 3389, source: n)
      end
    end
  end

  context 'the firewall disabled' do
    let(:overrides) { { bastion: { firewall: { enabled: false } } } }

    it 'disables the firewall' do
      expect(chef_run).to disable_firewall('default')
    end
  end
end
