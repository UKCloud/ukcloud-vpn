# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "skyscape-vpn"
  spec.version       = Skyscape::Vcloud::Ipsec::VERSION
  spec.authors       = ["Tim Lawrence"]
  spec.email         = ["tlawrence@skyscapecloud.com"]

  spec.summary       = %q{Configure vCloud Director IPSec VPNs}
  spec.homepage      = "https://github.com/skyscape-cloud-services"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "aruba"
  
  spec.add_runtime_dependency 'fog', '>=1.26.0'
  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'thor'
end
