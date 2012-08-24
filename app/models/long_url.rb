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
  def self.shorten(url)
    new_url = ''
    begin
      checker = Checker.new(UrlChecker.new(UrlRandomizer.new(BadWordFilter.new)))
      new_url = checker.verify_url(url)
    rescue => exception
      new_url = exception.message
    end

    new_url
  end
end
