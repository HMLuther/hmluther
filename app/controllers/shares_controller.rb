class SharesController < ApplicationController
  def new
    @share = Share.new
  end

  def create
    @share = Share.new(params[:share])
    @share.request = request
    if @share.deliver
      flash.now[:notice] = 'Your message has been sent'
    else
      flash.now[:error] = @share.errors.full_messages.to_sentence
      render :template => "remote_content/devise_errors.js.erb"
    end
  end
end