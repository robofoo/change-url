class UrlsController < ApplicationController
  def shorten
    @long_url = params[:url]
    @short_url = LongUrl.shorten(@long_url)
  end
end
