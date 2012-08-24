class LongUrl < ActiveRecord::Base
  has_many :short_urls
  attr_accessible :url
  validates :url, :presence => true

  def self.shorten(url)
    'jjj'
  end
end
