require 'yaml'

module UKCloud
  module Vcloud
    module Ipsec
      class Configuration
        attr_accessor :file_location, :full_config, :firewalls
        def initialize(file_location = "#{Dir.pwd}/firewalls.yml")
          @file_location = file_location
          raise("Configuration File Not Found At #{file_location}") unless File.exists?(file_location)
          
          @full_config = load_yaml
          @firewalls = parse_config
        end
        
        def load_yaml
          file = File.open(@file_location)
          conf = YAML.load(file)
          file.close
          
          symbolize(conf) unless conf == false
        end

        def find_firewall_by_name(name)
          @firewalls.detect do |firewall|
            firewall[:Name].eql? name
          end
        end

        def parse_config
          raise("No firewalls In Config File: #{@file_location}") unless @full_config.is_a?(Hash) && @full_config[:Firewalls]
          raise("No firewalls In Config File: #{@file_location}") unless @full_config[:Firewalls].is_a?(Array) && @full_config[:Firewalls].length > 0
          #To Do: Add Config Schema?  
          @full_config[:Firewalls]
          
          
        end
        
        private

        def symbolize(obj)
          return obj.reduce({}) do |memo, (k, v)|
            memo.tap { |m| m[k.to_sym] = symbolize(v) }
          end if obj.is_a? Hash
    
          return obj.reduce([]) do |memo, v| 
            memo << symbolize(v); memo
          end if obj.is_a? Array
  
          obj
        end
       
        
      end
    end
  end
end
