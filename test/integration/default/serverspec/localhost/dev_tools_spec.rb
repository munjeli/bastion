# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::dev_tools' do
  describe file('/usr/lib/jvm/java-8-oracle-amd64/bin/java') do
    it 'exists' do
      expect(subject).to be_file
    end
  end

  describe package('git') do
    it 'is installed' do
      expect(subject).to be_installed
    end
  end

  describe package('ruby-dev') do
    it 'is installed' do
      expect(subject).to be_installed
    end
  end

  describe package('bundler') do
    it 'is installed' do
      expect(subject).to be_installed.by('gem')
    end
  end

  describe command('gem -h') do
    it 'exits successfully' do
      expect(subject.exit_status).to eq(0)
    end
  end
end
