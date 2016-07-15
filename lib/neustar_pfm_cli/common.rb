require "digest/md5"
require "faraday"

def request 
  $api_key   = ENV["NEUSTAR_API_KEY"] 
  shared_key = ENV["NEUSTAR_SHARED_KEY"]
  timestamp  = Time.now.to_i
  $sig       = Digest::MD5.hexdigest($api_key + shared_key + timestamp.to_s)

  Faraday::Connection.new(:url => 'https://api.neustar.biz') do |builder|
    builder.use Faraday::Adapter::NetHttp
  end
end
