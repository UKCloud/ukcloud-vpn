require 'thor'
require './lib/main'
require './lib/version'

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
          Skyscape::Vcloud::Ipsec::Main.new(path)
        end
      end
    end
  end
end
