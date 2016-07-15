require "neustar_pfm_cli/common"
require "thor"
require "yaml"
require "json"

module NeustarPfmCli
  class LoadTest < Thor
    desc "list", "負荷試験の一覧を取得する"
    method_option :limit, :type => :string, :aliases => '-l', :desc => "取得する件数を指定", :default => "10"
    def ls
      begin
        res = request.get "/performance/load/1.0/list?limit=#{options[:limit]}&apikey=#{$api_key}&sig=#{$sig}"
        puts res.body
      rescue => e
        puts "[" + "\e[31m" + "ERROR" + "\e[0m" + "] #{e}"
      end
    end

    desc "delete", "負荷試験を削除する"
    method_option :id, :type => :string, :aliases => '-i', :desc => "loadTestId を指定する"
    def del
      begin
        res = request.delete "/performance/load/1.0/#{options[:id]}/delete?apikey=#{$api_key}&sig=#{$sig}"
        puts res.body
      rescue => e
        puts "[" + "\e[31m" + "ERROR" + "\e[0m" + "] #{e}"
      end
    end

    desc "sc", "負荷試験をスケジュールする"
    method_option :file, :type => :string, :aliases => '-f', :desc => "負荷試験定義ファイルのパスを指定"
    def sc
      begin
        params = load_loadtest_file(options[:file])
      rescue => e
        puts "[" + "\e[31m" + "ERROR" + "\e[0m" + "] #{e}"
      end

      begin
        res = request.post do |req|
          req.url "/performance/load/1.0/schedule?apikey=#{$api_key}&sig=#{$sig}"
          req.headers["Content-Type"] = "application/json"
          puts req.body = params.to_json
        end
        puts res.body
      rescue => e
        puts "[" + "\e[31m" + "ERROR" + "\e[0m" + "] #{e}"
        exit 1
      end

    end

    private

    def load_loadtest_file(filename)
      params = YAML.load_file(filename) 
      return params
    end

  end
end
