#UKCloud IPSec VPN Configuration Tool

This command line tool allows UKCloud customers using vShield Edge firewalls to configure IPSec tunnels using a configuration file written in "YAML"
For more information on YAML and it's syntax see: https://en.wikipedia.org/wiki/YAML



## Installation

First ensure Ruby is installed on your machine. 

To check you can run:

```batchfile
>ruby -v
ruby 2.0.0p247 (2013-06-27) [i386-mingw32]
```

The tool was built using Ruby 2.0.0p247 but other versions may work. 

And then install the gem using:
```batchfile
>gem install ukcloud-vpn
```

## Usage

Once installed the tool can be run by executing the following:

```batchfile
>ukcloud-vpn apply <path to yaml file>
```

For example:

```batchfile
>ukcloud-vpn apply c:\tmp\firewalls.yml
```

Or for Linux:

```batchfile
$ ukcloud-vpn apply /tmp/firewalls.yml
```


## Configuration File

The configuration file uses YAML as a format and defines one or more vShield Edge Firewalls to be configured. 
The file has the following syntax:

```yaml
Firewalls:
  - Name: Firewall_1
    Service:
      IsEnabled: true
    Creds:
      User: xxx.xxxx.xxx
      Password: xxxxxxxxxxxx
      Org: x-x-xx-xxxx
      Url: api.vcd.portal.ukcloud.com
      Edge: nftxxxxxx-x
    GatewayIpsecVpnService:
      IsEnabled: true
      Tunnel:
      - Name: west-to-east
        IpsecVpnLocalPeerId:
        IpsecVpnLocalPeerName:
        PeerIpAddress: 111.111.111.111
        PeerId: 111.111.111.111
        LocalIpAddress: 222.222.222.222
        LocalId: 222.222.222.222
        LocalSubnet:
        - Name: DMZ
          Gateway: 10.0.1.1
          Netmask: 255.255.255.0
        PeerSubnet:
        - Name: DMZ
          Gateway: 10.0.10.1
          Netmask: 255.255.255.0
        SharedSecret: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        EncryptionProtocol: AES256
        Mtu: 1400
        IsEnabled: true
  - Name: Firewall_2
    Creds:
      User: xxx.xxxx.xxx
      Password: xxxxxxxxxxxx
      Org: x-x-xx-xxxx
      Url: api.vcd.portal.ukcloud.com
      Edge: nftxxxxxx-x    
    GatewayIpsecVpnService:
      IsEnabled: true
      Tunnel:
      - Name: east-to-west
        IpsecVpnLocalPeerId:
        IpsecVpnLocalPeerName:
        PeerIpAddress: 222.222.222.222
        PeerId: 222.222.222.222
        LocalIpAddress: 111.111.111.111
        LocalId: 111.111.111.111
        PeerSubnet:
        - Name: DMZ
          Gateway: 10.0.1.1
          Netmask: 255.255.255.0
        LocalSubnet:
        - Name: DMZ
          Gateway: 10.0.10.1
          Netmask: 255.255.255.0
        SharedSecret: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        EncryptionProtocol: AES256
        Mtu: 1400
        IsEnabled: true
```


Note that a hyphen ( - ) in YAML represents an array item (an item which can appear one or more times). 
Hopefully it is clear from the example file above the the file supports:
 * One or more vShield firewalls per file
 * One or more tunnels per vShield firewall
 * One or more local subnet per tunnel
 * One or more peer subnet per tunnel


**PeerIpAddress** & **PeerId** should be set to the public IP address of the remote vShield Firewall  
**LocalIpAddress** & **LocalId** should be set to the public IP address of the local vShield Firewall


The file can be created in any text editor (notepad etc) and is usually saved with a ".yml" file extension although this is not required by the tool.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ukcloud-cloud-services/ukcloud-vpn.
Please ensure that the tests run successfully before creating a PR and consider increasing the coverage if adding new features.

### Testing

The project has unit tests using Rspec which can be run using:

```batchfile
>bundle exec rspec
```

One of the tests configures a VPN using the firewalls.yml file and a mocked HTTP connection to vCloud Director API. The UKCloud VPN tool will print out what it is doing as it does it, so you can also verify that the tool still works by checking the output in the console against this list:

```bash
UKCloud::Vcloud::Ipsec::Configuration
  loading current configuration using the vCloud API
Connecting to vCloud Director API
Connected to vCloud Director API
Getting vShield Edge HREF From Query
Finished Getting vShield Edge HREF From Query
Configuring VPN Service For Firewall: nftxxxxxx-x
  Task:  Completed With Status: completed
Finished Configuring VPN Service For Firewall: nftxxxxxx-x
Connecting to vCloud Director API
Connected to vCloud Director API
Getting vShield Edge HREF From Query
Finished Getting vShield Edge HREF From Query
Configuring VPN Service For Firewall: nftxxxxxx-x
  Task:  Completed With Status: completed
Finished Configuring VPN Service For Firewall: nftxxxxxx-x
```

The CLI tests are written using Cucumber & Aruba and can be run using:

```batchfile
>bundle exec cucumber
```

Note: Cucumber tests do not appear to work on Windows

