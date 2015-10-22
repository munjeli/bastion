# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::logging' do
  let(:runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { runner.converge(described_recipe) }

  it 'installs Snoopy' do
    expect(chef_run).to include_recipe('snoopy')
  end

  it 'installs auditd' do
    expect(chef_run).to install_package('auditd')
  end

  it 'configures the base audit rules' do
    f = '/etc/audit/rules.d/audit.rules'
    expect(chef_run).to create_file(f)
    expect(chef_run.file(f)).to notify('execute[augenrules]').to(:run)
  end

  it 'enables and starts the auditd service' do
    expect(chef_run).to enable_service('auditd')
    expect(chef_run).to start_service('auditd')
  end

  it 'creates an augenrules execute resource' do
    expect(chef_run.execute('augenrules')).to do_nothing
    expect(chef_run.execute('augenrules')).to notify('service[auditd]')
      .to(:restart)
  end
end
