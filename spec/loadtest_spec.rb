require "spec_helper"

describe NeustarPfmCli::LoadTest do

  it "LoadTest の ls コマンドの結果に ERROR が含まれていること" do
    capture(:stdout) {
      NeustarPfmCli::LoadTest.new.invoke(:ls, [])
    }.strip.should be_include "ERROR"
  end

  it "LoadTest の get コマンドの結果に ERROR が含まれていること" do
    capture(:stdout) {
      NeustarPfmCli::LoadTest.new.invoke(:get, [], {id: "123456"})
    }.strip.should be_include "ERROR"
  end
end
