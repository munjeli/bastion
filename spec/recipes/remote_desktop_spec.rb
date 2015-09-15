# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::remote_desktop' do
  let(:platform) { { platform: 'ubuntu', version: '14.04' } }
  let(:method) { nil }
  let(:runner) do
    ChefSpec::SoloRunner.new(platform) do |node|
      node.set['bastion']['remote_desktop']['method'] = method if method
    end
  end
  let(:chef_run) { runner.converge(described_recipe) }

  it 'installs the X2go server' do
    expect(chef_run).to include_recipe('x2go-server')
  end

  it 'configures the Google Chrome APT repo' do
    expect(chef_run).to add_apt_repository('google-chrome')
      .with(uri: 'http://dl.google.com/linux/chrome/deb',
            distribution: 'stable',
            components: %w(main),
            key: 'https://dl-ssl.google.com/linux/linux_signing_key.pub')
  end

  %w(xorg fluxbox dbus-x11 google-chrome-stable firefox).each do |p|
    it "installs #{p}" do
      expect(chef_run).to install_package(p)
    end
  end
end
