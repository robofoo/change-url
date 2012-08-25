class PagesController < ApplicationController
  def home
    if params.has_key?(:url)
      @long_url = params[:url]

      begin
        @short_url = LongUrl.shorten(@long_url)
        flash.now[:status] = 'success message here'
      rescue => exception
        flash.now[:error] = exception.message
      end

      render :action => 'home'
    end
  end
end
