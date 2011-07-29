require 'spec_helper'

describe Loggly do

	before(:all) do
		@test_uri = 'example.loggly.com'
		@test_user = 'user'
		@test_pass = 'pass'
		@test_key = '123456'
		@loggly = Loggly.new(
			:uri => @test_uri, 
			:user => @test_user, 
			:pass => @test_pass, 
			:key => @test_key
		)
	end

	it "should throw an exception if no URI is passed" do

	end	

	describe "#search" do

		before(:each) do
			RestClient.stub!(:get)
		end

		it "should generate an appropriate RestClient get request" do
			search_string = "search string"
			RestClient.should_receive(:get).with(@test_uri, {:params => {:q => search_string}})
			@loggly.search("search string")
		end
	end

	describe "#log" do
		
		before(:each) do
			RestClient.stub!(:post)
		end

		it "should generate an appropriate RestClient POST" do
			RestClient.should_receive(:post)
			@loggly.log('this is a log')
		end
	end

end
