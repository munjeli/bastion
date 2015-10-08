# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::dev_tools' do
  let(:runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { runner.converge(described_recipe) }

  it 'installs Git' do
    expect(chef_run).to install_package('git')
  end

  it 'installs Ruby' do
    expect(chef_run).to install_package('ruby-dev')
  end

  it 'installs Bundler' do
    expect(chef_run).to install_gem_package('bundler')
  end

  it 'installs Rake' do
    expect(chef_run).to install_gem_package('rake')
  end
end
