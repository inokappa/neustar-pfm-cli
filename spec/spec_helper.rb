require 'rubygems'
require 'neustar_pfm_cli/common'
require 'neustar_pfm_cli/loadtest'
require 'neustar_pfm_cli/scripting'

RSpec.configure do |config|
  config.mock_framework = :rspec
  config.expect_with(:rspec) { |c| c.syntax = :should }

  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end
end
