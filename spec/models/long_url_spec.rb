require 'spec_helper'

describe LongUrl do
  describe "#shorten" do
    it 'shortens a long url' do
      url = LongUrl.shorten('lkjsdf')
      url.should == 'jjj'
    end
  end
end
