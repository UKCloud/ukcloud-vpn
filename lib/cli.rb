require 'thor'
require 'main'
require 'version'

module UKCloud
  module Vcloud
    module Ipsec
      class Cli < Thor
	desc "version", "Print ukcloud-vpn version" 


        def version
          puts UKCloud::Vcloud::Ipsec::VERSION
        end


        desc "apply <location>", "Begin configuration of IPSec tunnels"
        def apply(path)
          begin
            UKCloud::Vcloud::Ipsec::Main.new(path)
          rescue Exception => e
            puts e.message
          end
        end
      end
    end
  end
end
