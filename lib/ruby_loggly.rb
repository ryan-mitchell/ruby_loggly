require 'rest_client'

class Loggly

  def initialize(options)
    @subdomain = options[:subdomain]
    @user = options[:user]
    @pass = options[:pass]
    @key = options[:key]
    @ec2 = options[:ec2] ||= false
  end

  def log(log_data)
    ec2flag = @ec2 ? 'ec2.' : ''
    RestClient.post("https://#{ec2flag}logs.loggly.com/inputs/#{@key}", log_data)
  end

  def search(query)
    RestClient.get("https://#{@user}:#{@pass}@#{@subdomain}.loggly.com/api/search", {:params => {:q => query}})
  end

end
