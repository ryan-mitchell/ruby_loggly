require 'spec_helper'

describe Loggly do

  before(:all) do
    @test_subdomain = 'example'
    @test_user = 'user'
    @test_pass = 'pass'
    @test_key = '123456'
    @loggly = Loggly.new(
      :subdomain => @test_subdomain, 
      :user => @test_user, 
      :pass => @test_pass, 
      :key => @test_key
    )
  end

  describe "#search" do

    before(:each) do
      RestClient.stub!(:get)
      Kernel.stub!(:print)
    end

    it "should generate an appropriate RestClient GET" do

      search_string = "search string"
      RestClient.should_receive(:get).with(
        "https://#{@test_user}:#{@test_pass}@#{@test_subdomain}.loggly.com/api/search", 
        {:params => {:q => search_string}}
      )

      @loggly.search(search_string)
    end

    it "should execute the callback if one is provided" do

      Kernel.should_receive(:print).with('return data')
      RestClient.should_receive(:get).and_return('return data')

      @loggly.search('anything') do |data|
        Kernel.print data
      end
    end
  end

  describe "#log" do
    
    before(:each) do
      RestClient.stub!(:post)
    end

    it "should generate an appropriate RestClient POST with a raw payload" do

      log_string = "this is a test log"
      RestClient.should_receive(:post).with(
        "https://logs.loggly.com/inputs/%s" % @test_key,
        log_string
      )

      @loggly.log(log_string)
    end

    it "should generate an appropriate RestClient POST with parameters" do

      log_parameters = { :time => 123456, :type => 'foo', :logger => 'bar' }
      RestClient.should_receive(:post).with(
        "https://logs.loggly.com/inputs/%s" % @test_key,
        log_parameters
      )

      @loggly.log(log_parameters)
    end

    it "should use the EC2 host if the EC2 flag is set" do

      log_string = "this is a test log"
      ec2logger = Loggly.new(
        :subdomain => @test_subdomain, 
        :user => @test_user, 
        :pass => @test_pass, 
        :key => @test_key,
        :ec2 => true
      )
      RestClient.should_receive(:post).with(
        "https://ec2.logs.loggly.com/inputs/%s" % @test_key,
        log_string
      )

      ec2logger.log(log_string)
    end
  end
end
