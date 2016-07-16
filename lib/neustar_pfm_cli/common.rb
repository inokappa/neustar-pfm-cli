require "thor"
require "digest/md5"
require "faraday"
require "yaml"
require "json"
require 'logger'

def logger
  Logger.new(STDOUT)
end

def auth
  api_key    = ENV["NEUSTAR_API_KEY"] 
  shared_key = ENV["NEUSTAR_SHARED_KEY"]
  timestamp  = Time.now.to_i

  begin
    sig = Digest::MD5.hexdigest(api_key + shared_key + timestamp.to_s)
  rescue
    logger.error("[" + "\e[31m" + "ERROR" + "\e[0m" + "] 環境変数 NEUSTAR_API_KEY と NEUSTAR_SHARED_KEY を指定して下さい...")
    # exit 1
  end
  
  return api_key, sig
end

def request 
  Faraday::Connection.new(:url => 'https://api.neustar.biz') do |builder|
    builder.use Faraday::Adapter::NetHttp
  end
end
