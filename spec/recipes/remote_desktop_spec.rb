# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::remote_desktop' do
  let(:method) { nil }
  let(:runner) do
    ChefSpec::SoloRunner.new do |node|
      node.set['bastion']['remote_desktop']['method'] = method if method
    end
  end
  let(:chef_run) { runner.converge(described_recipe) }

  shared_examples_for 'any valid remote desktop method' do
    %w(xorg fluxbox dbus-x11).each do |p|
      it "installs #{p}" do
        expect(chef_run).to install_package(p)
      end
    end

    it 'installs Google Chrome' do
      expect(chef_run).to include_recipe('chrome')
    end

    it 'installs Firefox' do
      expect(chef_run).to install_package('firefox')
    end
  end

  context 'X11 forwarding remote desktop method' do
    let(:method) { :x11 }

    it_behaves_like 'any valid remote desktop method'

    it 'enables X11 forwarding' do
      sshd = chef_run.node['sshd']['sshd_config']
      expect(sshd['X11Forwarding']).to eq('yes')
      expect(sshd['X11UseLocalhost']).to eq('yes')
    end

    it 'configures sshd' do
      expect(chef_run).to include_recipe('sshd')
    end
  end

  context 'RDP remote desktop method' do
    let(:method) { :rdp }

    it_behaves_like 'any valid remote desktop method'

    it 'installs XRDP' do
      expect(chef_run).to include_recipe('xrdp')
    end

    it 'does not configure sshd' do
      expect(chef_run).to_not include_recipe('sshd')
    end
  end

  context 'an invalid remote desktop method' do
    let(:method) { :other }

    it 'raises an error' do
      expect { chef_run }.to raise_error(Chef::Exceptions::ValidationFailed)
    end
  end
end
