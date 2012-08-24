class AddLongUrlIdToShortUrl < ActiveRecord::Migration
  def change
    add_column :short_urls, :long_url_id, :int
  end
end
