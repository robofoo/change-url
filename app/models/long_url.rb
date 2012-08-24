class LongUrl < ActiveRecord::Base
  has_many :short_urls
  attr_accessible :url
end
