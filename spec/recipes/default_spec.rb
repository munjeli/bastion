# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::default' do
  let(:runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { runner.converge(described_recipe) }

  it 'includes the xrdp recipe' do
    expect(chef_run).to include_recipe('xrdp')
  end
end
