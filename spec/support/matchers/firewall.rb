if defined?(ChefSpec)
  [:firewall, :firewall_rule].each { |r| ChefSpec.define_matcher(r) }

  [:enable, :disable].each do |a|
    define_method("#{a}_firewall") do |name|
      ChefSpec::Matchers::ResourceMatcher.new(:firewall, a, name)
    end
  end

  def allow_firewall_rule(name)
    ChefSpec::Matchers::ResourceMatcher.new(:firewall_rule, :allow, name)
  end
end
