require 'spec_helper'

describe LongUrl do
  describe "#shorten" do
    it 'shorten valid urls' do
      lurl = 'www.googl.com'
      surl = LongUrl.shorten(lurl)
      surl.length.should < lurl.length
    end

    it 'generate random short url' do
      lurl = 'www.google.com'
      surl1 = LongUrl.shorten(lurl)
      surl2 = LongUrl.shorten(lurl)
      surl1.should_not == surl2
    end

    it 'errors for invalid urls' do
      badurl = 'thisisnonsense'
      newurl = LongUrl.shorten(badurl)
      newurl.match(/badly formatted/).should be
    end

    it 'does not allow bad words (foo)' do
      badword = 'foo'
      newurl = LongUrl.shorten(badword)
      newurl.match(/bad words/).should be
    end

    it 'does not allow bad words (bar)' do
      badword = 'bar'
      newurl = LongUrl.shorten(badword)
      newurl.match(/bad words/).should be
    end

    it 'short urls differ by at least 2 chars' do
      pending
    end
  end
end

describe UrlRandomizer do
  it 'does not create dupes' do
    #ur = UrlRandomizer.new
    #ur.randomize
    
  end
end
