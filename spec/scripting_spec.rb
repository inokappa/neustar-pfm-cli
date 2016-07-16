require "spec_helper"

describe NeustarPfmCli::Scripting do
  it "Scripting の ls コマンドの結果に ERROR が含まれていること" do
    capture(:stdout) {
      NeustarPfmCli::Scripting.new.invoke(:ls, [])
    }.strip.should be_include "ERROR"
  end
end
