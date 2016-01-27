require 'thor'
require 'main'
require 'version'

module Skyscape
  module Vcloud
    module Ipsec
      class Cli < Thor
	desc "version", "Print skyscape-vpn version" 


        def version
          puts Skyscape::Vcloud::Ipsec::VERSION
        end


        desc "apply <location>", "Begin configuration of IPSec tunnels"
        def apply(path)
          begin
            Skyscape::Vcloud::Ipsec::Main.new(path)
          rescue Exception => e
            puts e.message
          end
        end
      end
    end
  end
end
