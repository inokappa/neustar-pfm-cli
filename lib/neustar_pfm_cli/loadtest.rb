require "neustar_pfm_cli/common"

module NeustarPfmCli
  class LoadTest < Thor
    desc "ls", "負荷試験の一覧を取得する"
    method_option :limit, :type => :string, :aliases => '-l', :desc => "取得する件数を指定する", :default => "10"
    def ls
      begin
        res = request.get "/performance/load/1.0/list?limit=#{options[:limit]}&apikey=#{auth[0]}&sig=#{auth[1]}"
        puts res.body
      rescue => e
        logger.error("[" + "\e[31m" + "ERROR" + "\e[0m" + "] #{e}")
        # exit 1
      end
    end

    desc "get", "負荷試験の情報を取得する"
    method_option :id, :type => :string, :aliases => '-i', :desc => "loadTestId を指定する"
    def get
      begin
        res = request.get "/performance/load/1.0/id/#{options[:id]}?apikey=#{auth[0]}&sig=#{auth[1]}"
        puts res.body
      rescue => e
        logger.error("[" + "\e[31m" + "ERROR" + "\e[0m" + "] #{e}")
        # exit 1
      end
    end

    desc "del", "負荷試験を削除する"
    method_option :id, :type => :string, :aliases => '-i', :desc => "loadTestId を指定する"
    def del
      begin
        res = request.delete "/performance/load/1.0/#{options[:id]}/delete?apikey=#{auth[0]}&sig=#{auth[1]}"
        puts res.body
      rescue => e
        logger.error("[" + "\e[31m" + "ERROR" + "\e[0m" + "] #{e}")
        # exit 1
      end
    end

    desc "sc", "負荷試験をスケジュールする"
    method_option :file, :type => :string, :aliases => '-f', :desc => "負荷試験定義ファイルのパスを指定"
    def sc
      begin
        params = load_loadtest_file(options[:file])
      rescue => e
        logger.error("[" + "\e[31m" + "ERROR" + "\e[0m" + "] 負荷試験定義ファイルのパスを指定して下さい...")
        # exit 1
      end

      begin
        res = request.post do |req|
          req.url "/performance/load/1.0/schedule?apikey=#{auth[0]}&sig=#{auth[1]}"
          req.headers["Content-Type"] = "application/json"
          puts req.body = params.to_json
        end
        puts res.body
      rescue => e
        logger.error("[" + "\e[31m" + "ERROR" + "\e[0m" + "] #{e}")
        # exit 1
      end

    end

    private

    #require "digest/md5"
    #require "faraday"
    #
    #def auth 
    #  api_key    = ENV["NEUSTAR_API_KEY"] 
    #  shared_key = ENV["NEUSTAR_SHARED_KEY"]
    #  timestamp  = Time.now.to_i
    #  sig        = Digest::MD5.hexdigest(api_key + shared_key + timestamp.to_s)

    #  return api_key, sig
    #end
    #
    #def request 
    #  Faraday::Connection.new(:url => 'https://api.neustar.biz') do |builder|
    #    builder.use Faraday::Adapter::NetHttp
    #  end
    #end


    def load_loadtest_file(filename)
      params = YAML.load_file(filename) 
      return params
    end

  end
end
