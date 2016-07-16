require "spec_helper"

describe NeustarPfmCli::LoadTest do
  it "ls コマンドの結果に data が含まれていること" do
    capture(:stdout) {
      NeustarPfmCli::LoadTest.new.invoke(:ls, [])
    }.strip.should be_include "data"
  end

  it "get コマンドの結果に data が含まれていること" do
    capture(:stdout) {
      NeustarPfmCli::LoadTest.new.invoke(:get, [])
    }.strip.should be_include "data"
  end
end
