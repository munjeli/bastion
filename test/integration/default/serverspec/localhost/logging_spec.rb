# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::logging' do
  describe package('snoopy') do
    it 'is installed' do
      expect(subject).to be_installed
    end
  end

  describe file('/etc/ld.so.preload') do
    it 'loads the snoopy lib' do
      expect(subject.content).to match(%r{^/lib/libsnoopy\.so$})
    end
  end

  describe file('/etc/snoopy.ini') do
    it 'is configured to only log commands with a TTY' do
      expect(subject.content).to match(/^filter_chain = only_tty:$/)
    end
  end

  describe file('/var/log/auth.log') do
    it 'is logging system commands' do
      `ls`
      expect(subject.content).to match(%r{snoopy.*filename:/bin/ls})
    end
  end

  describe package('auditd') do
    it 'is installed' do
      expect(subject).to be_installed
    end
  end

  describe service('auditd') do
    it 'is enabled' do
      expect(subject).to be_enabled
    end

    unless `ps h -p 1 -o command`.start_with?('/usr/sbin/sshd')
      it 'is running' do
        expect(subject).to be_running
      end
    end
  end

  describe file('/etc/audit/audit.rules') do
    it 'uses the STIG ruleset' do
      expected = %r{^-w /etc/network -p wa -k system-locale$}
      expect(subject.content).to match(expected)
      expected = %r{^-w /etc/sudoers -p wa -k actions$}
      expect(subject.content).to match(expected)
    end
  end
end
