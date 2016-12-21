require 'spec_helper'

describe UKCloud::Vcloud::Ipsec::Configuration do
  context "After loading the config file" do
    before :each do
       file = "#{Dir.pwd}/spec/fixtures/firewalls.yml"
       @firewall = UKCloud::Vcloud::Ipsec::Configuration.new(file).find_firewall_by_name("Firewall_1")
    end

    it "returns correct name of a firewall" do
      expect(@firewall[:Name]).to eq("Firewall_1")
    end

    it "can work out whether the gateway is enabled" do
      expect(@firewall[:GatewayIpsecVpnService][:IsEnabled]).to eq(true)
    end
  end
end
