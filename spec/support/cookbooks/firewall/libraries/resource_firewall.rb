# Encoding: UTF-8

require 'chef/resource/lwrp_base'

class Chef
  class Resource
    # A fake firewall resource.
    #
    # @author Jonathan Hartman <jonathan.hartman@socrata.com>
    class Firewall < Resource::LWRPBase
      self.resource_name = :firewall
      actions :enable, :disable
    end
  end
end
