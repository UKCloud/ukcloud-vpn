require 'spec_helper'
require 'active_support/core_ext/hash/conversions'

describe UKCloud::Vcloud::Ipsec::Configuration do
  context 'loading current configuration using the vCloud API' do
    before do
      stub_request(:post, "https://api.vcd.portal.skyscapecloud.com/api/sessions")
        .to_return(:status => 200, :body => {return_body: "let"}.to_xml, :headers => { "CONTENT_TYPE" => "application/xml"} )

      stub_request(:get, "https://api.vcd.portal.skyscapecloud.com/api/query?filter=name==nftxxxxxx-x&type=edgeGateway")
        .to_return(:status => 200, :body => query_response_body.to_xml, :headers => { "CONTENT_TYPE" => "application/xml" } )

      stub_request(:post, "https://api.vcd.portal.skyscapecloud.com/api/admin/edgeGateway/639f07a1-4644-40bd-9f91-e85008850398/action/configureServices")
        .to_return(:status => 202, :body => configure_response_body.to_xml, :headers => { "CONTENT_TYPE" => "application/xml" })

      stub_request(:get, "https://api.vcd.portal.skyscapecloud.com/api/task/news")
        .to_return(:status => 200, :body => { status: "completed" }.to_xml, :headers => {})
    end

    it 'modifies the configuration of a VPN' do
      file = "#{Dir.pwd}/spec/fixtures/firewalls.yml"
      expect(!!UKCloud::Vcloud::Ipsec::Main.new(file)).to eq(true)
    end
  end

  private def query_response_body
    {
      :total => 1,
      :EdgeGatewayRecord => {
        :href => "https://api.vcd.portal.skyscapecloud.com/api/admin/edgeGateway/639f07a1-4644-40bd-9f91-e85008850398"
      }
    }
  end

  private def configure_response_body
    {
      :href => "http://www.bbc.co.uk/news"
    }
  end
end
