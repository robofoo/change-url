class PagesController < ApplicationController
  def home
    if params.has_key?(:url)
      @long_url = params[:long_url]
      @short_url = LongUrl.shorten(@long_url)

      flash[:status] = 'other notice'
      redirect_to :action => 'home'
    end
  end
end
