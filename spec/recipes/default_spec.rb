# Encoding: UTF-8

require_relative '../spec_helper'

describe 'bastion::default' do
  let(:runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { runner.converge(described_recipe) }

  %w(apt bastion::firewall bastion::remote_desktop bastion::logging).each do |r|
    it "includes the '#{r}' recipe" do
      expect(chef_run).to include_recipe(r)
    end
  end
end
