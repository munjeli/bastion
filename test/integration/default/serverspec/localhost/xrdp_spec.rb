# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::default' do
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
