require "neustar_pfm_cli/common"
require "yaml"
require "json"
require "open3"

module NeustarPfmCli
  class Scripting < Thor

    desc "list", "シナリオスクリプト一覧を取得する"
    method_option :limit, :type => :string, :aliases => '-l', :desc => "取得する件数を指定", :default => "10"
    def ls
      begin
        res = request.get "/performance/script/1.0/ValidScripts/?limit#{options[:limit]}&apikey=#{$api_key}&sig=#{$sig}"
        puts res.body
      rescue => e
        puts "[" + "\e[31m" + "ERROR" + "\e[0m" + "] #{e}"
        exit 1
      end
    end

    desc "validate", "シナリオスクリプトを Local Validator を使って validate する"
    method_option :file, :type => :string, :aliases => '-f', :desc => "スクリプトファイルのパスを指定"
    def val
      begin
        unless ENV["NEUSTAR_LOCAL_VALIDATOR_PATH"] == nil then
          Open3.popen3("#{ENV["NEUSTAR_LOCAL_VALIDATOR_PATH"]} -verbose #{options[:file]}") do |stdin, stdout, stderr|
            puts "\e[32m" + stdout.read + "\e[0m"
            puts "\e[33m" + stderr.read + "\e[0m"
          end
        else
          puts "[" + "\e[31m" + "ERROR" + "\e[0m" + "] 環境変数 NEUSTAR_LOCAL_VALIDATOR_PATH に Local Validator のパスを指定して下さい!!"
          exit 1
        end
      rescue => e
        puts "[" + "\e[31m" + "ERROR" + "\e[0m" + "] #{e}"
        exit 1
      end
    end
  
    desc "upload", "シナリオスクリプトをアップロードする"
    method_option :name, :type => :string, :aliases => '-n', :desc => "スクリプト名を指定"
    method_option :file, :type => :string, :aliases => '-f', :desc => "スクリプトファイルのパスを指定"
    method_option :tags, :type => :string, :aliases => '-t', :desc => "スクリプトの Tag を指定", :require => false
    method_option :desc, :type => :string, :aliases => '-d', :desc => "スクリプトの Description を指定", :require => false
    def up

      begin
        tags = { "tags" => options[:tags].split(",") }
        desc = { "description" => options[:desc] }
        params = tags.merge(desc)
      rescue => e
        puts "[" + "\e[31m" + "ERROR" + "\e[0m" + "] #{e}"
      end

      begin
        res = request.post do |req|
          req.url "/performance/script/1.0/upload/body?apikey=#{$api_key}&sig=#{$sig}"
          req.headers["Content-Type"] = "application/json"
          puts req.body = {
            "name": options[:name],
            "scriptBody": load_scenario_file(options[:file])
          }.merge(params).to_json
        end
        puts res.body
      rescue => e
        puts "[" + "\e[31m" + "ERROR" + "\e[0m" + "] #{e}"
        exit 1
      end
    end

    private

    def load_scenario_file(file_name)
      file = open(file_name)
      scenario = file.read
      file.close
      return scenario
    end
  
  end
end
