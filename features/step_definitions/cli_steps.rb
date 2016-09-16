require './lib/version'

Then(/^the (stdout) should contain version$/) do |version|
  expect(last_command_stopped).to have_output an_output_string_matching(UKCloud::Vcloud::Ipsec::VERSION)
  
end

