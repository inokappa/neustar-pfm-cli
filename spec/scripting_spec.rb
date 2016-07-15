require "spec_helper"

describe NeustarPfmCli::Scripting do
  it "ls コマンドの結果に data が含まれていること" do
    capture(:stdout) {
      NeustarPfmCli::Scripting.new.invoke(:ls, [])
    }.strip.should be_include "data"
  end
end
