class PagesController < ApplicationController
  def home
    if params.has_key?(:url)
      @long_url = params[:url]

      begin
        @short_url = LongUrl.shorten(@long_url)
        flash.now[:status] = 'Success!'
      rescue => exception
        flash.now[:error] = exception.message
      end

      render :action => 'home'
    end
  end

  def expand
    url = params[:url]
    surl = ShortUrl.find_by_url(url)

    if surl
      @long_url = surl.long_url.url
    else
      @long_url = 'n/a'
      flash[:error] = "Sorry, no matching long url found for '#{url}'"
    end
  end
end
