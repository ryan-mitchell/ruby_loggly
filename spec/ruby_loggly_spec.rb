require 'spec_helper'

describe Loggly, "#search" do

	before(:each) do
		@test_uri = 'example.loggly.com'
		@test_user = 'user'
		@test_pass = 'pass'
		@loggly = Loggly.new(@test_uri, @test_user, @test_pass)
		RestClient.stub!(:get)
	end

	it "should generate an appropriate RestClient get request" do
		search_string = "search string"
		RestClient.should_receive(:get).with(@test_uri, {:params => {:q => search_string}})
		@loggly.search("search string")
	end
end
