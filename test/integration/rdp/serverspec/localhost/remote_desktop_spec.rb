# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::remote_desktop' do
  %w(xorg fluxbox dbus-x11 google-chrome-stable firefox).each do |p|
    described(package(p)) do
      it 'is installed' do
        expect(subject).to be_installed
      end
    end
  end

  describe file('/etc/ssh/sshd_config') do
    it 'does not have X11 forwarding enabled' do
      expect(subject.content).to_not match(/^X11Forwarding yes$/)
    end
  end

  describe package('xrdp') do
    it 'is installed' do
      expect(subject).to be_installed
    end
  end

  describe service('xrdp') do
    it 'is enabled' do
      expect(subject).to be_enabled
    end

    it 'is running' do
      expect(subject).to be_running
    end
  end
end
