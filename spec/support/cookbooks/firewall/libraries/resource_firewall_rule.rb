# Encoding: UTF-8

require 'chef/resource/lwrp_base'

class Chef
  class Resource
    # A fake firewall_rule resource.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class FirewallRule < Resource::LWRPBase
      self.resource_name = :firewall_rule
      actions :allow
      attribute :protocol, kind_of: Symbol
      attribute :port, kind_of: Fixnum
      attribute :source, kind_of: String
    end
  end
end
