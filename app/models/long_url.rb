require './app/models/chainable'

class LongUrl < ActiveRecord::Base
  has_many :short_urls
  attr_accessible :url
  validates :url, :presence => true

  # verify valid url to shorten
  # generate random short url
  # verify not a bad word
  # verify unique
  # create variations
  def self.shorten(long_url)
    short_url = ''
    begin
      checker = Checker.new(
                  UrlChecker.new(
                    UrlRandomizer.new(
                      BadWordFilter.new
                    )
                  )
                )
      short_url = checker.verify_url(long_url)
      # LongUrl handles it since it references short_urls
      LongUrl.add_urls(long_url, short_url)
    rescue => exception
      raise exception
    end

    short_url
  end

  def self.add_urls(long_url, short_url)
    ref_url = LongUrl.new(url:long_url)
    ref_url.save!

    # add similar urls
    similar = [short_url]
    similar << short_url.gsub('l', '1') if short_url.include?('l')
    similar << short_url.gsub('1', 'l') if short_url.include?('1')
    similar << short_url.gsub('o', '0') if short_url.include?('o')
    similar << short_url.gsub('0', 'o') if short_url.include?('0')

    similar.each do |sim|
      ShortUrl.new(url:sim).tap do |surl|
        surl.long_url = ref_url
        surl.save!
      end
    end
  end
end
