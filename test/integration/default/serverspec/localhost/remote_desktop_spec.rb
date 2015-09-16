# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::remote_desktop' do
  %w(xorg fluxbox dbus-x11 google-chrome-stable firefox).each do |p|
    describe(package(p)) do
      it 'is installed' do
        expect(subject).to be_installed
      end
    end
  end

  describe package('x2goserver') do
    it 'is installed' do
      expect(subject).to be_installed
    end
  end

  describe service('x2goserver') do
    it 'is enabled' do
      expect(subject).to be_enabled
    end

    it 'is running' do
      expect(subject).to be_running
    end
  end
end
