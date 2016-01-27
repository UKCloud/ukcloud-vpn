require 'fog'
require 'configuration'


module Skyscape
  module Vcloud
    module Ipsec
      class Main
        attr_accessor :config
        def initialize(config_file)
          @config = Skyscape::Vcloud::Ipsec::Configuration.new(config_file)
          configure_firewalls(@config.firewalls)
        
        end
        
        def configure_firewalls(firewalls)
          firewalls.each do |firewall| 
            configure_firewall(firewall)
          end
        end
        
        def configure_firewall(firewall)
          creds = firewall[:Creds]
          connection = vcloud_login(creds)
          edge_id = get_edge_href(creds[:Edge],connection).split('/').last
          
          puts "Configuring VPN Service For Firewall: #{creds[:Edge]}"
          task = connection.post_configure_edge_gateway_services(edge_id,firewall).body
          monitor_task(task[:href].split('/').last,connection)
          puts "Finished Configuring VPN Service For Firewall: #{creds[:Edge]}"
          
          #TO DO: SUPPORT MERGING CONFIG WITH EXISTING
          #current_config = get_current_config(edge_href,connection)
          #new_config = merge_configs(current_config, new_config)
          
        end
        
        def vcloud_login(creds)
          puts "Connecting to vCloud Director API"
          connection = Fog::Compute::VcloudDirector.new(
            :vcloud_director_username => "#{creds[:User]}@#{creds[:Org]}",
            :vcloud_director_password => creds[:Password],
            :vcloud_director_host => creds[:Url],
            :vcloud_director_show_progress => true, # task progress bar on/off
            :connection_options => {
              :omit_default_port => true
              }
            )
          puts "Connected to vCloud Director API"
            
          connection
        end
        
        def get_edge_href(edge_name, connection)
          puts "Getting vShield Edge HREF From Query"
          results = connection.get_execute_query(type="edgeGateway", :filter => "name==#{edge_name}").body
          
          raise "Edge #{edge_name} Not Found!" unless results[:total] == "1"
          raise "Edge Name #{edge_name} Not Unique!" if results[:total].to_i > 1
          puts "Finished Getting vShield Edge HREF From Query"
          result = results[:EdgeGatewayRecord][:href]
        end
        
        def get_current_config(edge_href,connection)
          configuration = connection.get_edge_gateway(edge_href.split('/').last).body
          
          vpn_service =  configuration[:Configuration][:EdgeGatewayServiceConfiguration][:GatewayIpsecVpnService]
        end
        
        def monitor_task(task_id,connection)
          task = connection.get_task(task_id).body
          while(task[:status] == "running") do
            puts "  Task: #{task[:operation]} Still Running"
            task = connection.get_task(task_id).body
            sleep(3)
          end
          
          puts "  Task: #{task[:operation]} Completed With Status: #{task[:status]}"
        end
      end
    end
  end
end
