require "spec_helper"

describe NeustarPfmCli::Scripting do
  context "API キーと Shared Key を指定していない場合" do

    it "Scripting の ls コマンドの結果に ERROR が含まれている" do
      capture(:stdout) {
        NeustarPfmCli::Scripting.new.invoke(:ls, [])
      }.strip.should be_include "403"
    end

    it "Scripting の up コマンドの結果に ERROR が含まれている" do
      capture(:stdout) {
        NeustarPfmCli::Scripting.new.invoke(:up, [])
      }.strip.should be_include ""
    end

  end

  context "NEUSTAR_LOCAL_VALIDATOR_PATH を指定していない場合" do
    it "Scripting の val コマンドの結果に NEUSTAR_LOCAL_VALIDATOR_PATH が含まれている" do
      capture(:stdout) {
        NeustarPfmCli::Scripting.new.invoke(:val, [])
      }.strip.should be_include ""
    end
  end

end
