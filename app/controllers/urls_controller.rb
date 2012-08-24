class UrlsController < ApplicationController
  def shorten
    @long_url = params[:url]
    @short_url = 'short url'
  end
end
