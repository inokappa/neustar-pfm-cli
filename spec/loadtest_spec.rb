require "spec_helper"

describe NeustarPfmCli::LoadTest do

  context "API キーと Shared Key を指定していない場合" do

    it "LoadTest の ls コマンドの結果に 403 が含まれている" do
      capture(:stdout) {
        NeustarPfmCli::LoadTest.new.invoke(:ls, [])
      }.strip.should be_include "403"
    end

    it "LoadTest の get コマンドの結果に 403 が含まれている" do
      capture(:stdout) {
        NeustarPfmCli::LoadTest.new.invoke(:get, [], {id: "123456"})
      }.strip.should be_include "403"
    end

    it "LoadTest の sc コマンドの結果に 403 が含まれている" do
      capture(:stdout) {
        NeustarPfmCli::LoadTest.new.invoke(:sc, [])
      }.strip.should be_include "403"
    end

    it "LoadTest の del コマンドの結果に 403 が含まれている" do
      capture(:stdout) {
        NeustarPfmCli::LoadTest.new.invoke(:del, [])
      }.strip.should be_include "403"
    end
  end

end
