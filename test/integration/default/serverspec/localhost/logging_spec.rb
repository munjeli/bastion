# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::logging' do
  describe package('auditd') do
    it 'is installed' do
      expect(subject).to be_installed
    end
  end

  describe service('auditd') do
    it 'is enabled' do
      expect(subject).to be_enabled
    end

    it 'is running' do
      expect(subject).to be_running
    end
  end

  describe file('/etc/audit/audit.rules') do
    it 'uses the STIG ruleset' do
      expected = %r{^-w /etc/network -p wa -k system-locale$}
      expect(subject.content).to match(expected)
      expected = %r{^-w /etc/sudoers -p wa -k actions$}
      expect(subject.content).to match(expected)
    end

    it 'logs all commands executed' do
      expected = /^-a exit,always -F arch=b64 -S execve$/
      expect(subject.content).to match(expected)
    end
  end
end
