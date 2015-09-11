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
    it 'has X11 forwarding enabled' do
      expect(subject.content).to match(/^X11Forwarding yes$/)
    end

    it 'has X11 forwarding using localhost' do
      expect(subject.content).to match(/^X11UseLocalhost yes$/)
    end
  end

  describe package('xrdp') do
    it 'is not installed' do
      expect(subject).to_not be_installed
    end
  end

  describe service('xrdp') do
    it 'is not enabled' do
      expect(subject).to_not be_enabled
    end

    it 'is not running' do
      expect(subject).to_not be_running
    end
  end
end
