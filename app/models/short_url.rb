class ShortUrl < ActiveRecord::Base
  belongs_to :long_url
  attr_accessible :url
end
