require 'spec_helper'

describe Skyscape::Vcloud::Ipsec::Configuration do
  
  before :each do
     @test = Skyscape::Vcloud::Ipsec::Configuration.new("#{Dir.pwd}/spec/fixtures/firewalls.yml")
  end
  
  describe "Configurations" do
    it "Default Loads From Current Directory" do
      file_name = "#{Dir.pwd}/firewalls.yml"
      FileUtils.cp("#{Dir.pwd}/spec/fixtures/firewalls.yml","#{Dir.pwd}/firewalls.yml")
      
      
      @test = Skyscape::Vcloud::Ipsec::Configuration.new()

      expect(@test.file_location).to eq file_name
      
      
      File.delete(file_name)
    end
    
    it "allows a custom file location to be specified" do
      expect(@test.file_location).to eq "#{Dir.pwd}/spec/fixtures/firewalls.yml"
    end
    
    it "raises error if file doesn't exist" do
      expect{Skyscape::Vcloud::Ipsec::Configuration.new("#{Dir.pwd}/spec/fixtures/idontexist.yml")}.to raise_error("Configuration File Not Found At #{Dir.pwd}/spec/fixtures/idontexist.yml")
    end
    
    it "loads the file as yaml" do
      expect(@test.full_config).to be_a Hash
    end
    
    it "symbolizes the hash keys" do
      expect(@test.full_config.keys[0]).to be_a Symbol
    end

    
    it "raises an error unless there is at least one tunnel" do
      expect{Skyscape::Vcloud::Ipsec::Configuration.new("#{Dir.pwd}/spec/fixtures/nofirewalls.yml")}.to raise_error("No firewalls In Config File: #{Dir.pwd}/spec/fixtures/nofirewalls.yml")
    end
    
    it "has an array of firewalls" do
      firewalls = @test.firewalls
      expect(firewalls).to be_a Array
    end
  end
  

end