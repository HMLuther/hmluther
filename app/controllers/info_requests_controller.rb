class InfoRequestsController < ApplicationController
  def new
    @info_request = InfoRequest.new
  end

  def create
    @info_request = InfoRequest.new(params[:info_request])
    @info_request.request = request
    if @info_request.deliver
      # redirect_to :back
      # flash.now[:error] = nil
      flash.now[:notice] = 'Thank you for your message!'
    else
      flash.now[:error] = @info_request.errors.full_messages.to_sentence
      # render :new
      render :template => "remote_content/devise_errors.js.erb"
    end
  end
end