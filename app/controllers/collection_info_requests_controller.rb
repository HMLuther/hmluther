class CollectionInfoRequestsController < ApplicationController
  def new
    @collection_info_request = CollectionInfoRequest.new
  end

  def create
    @collection_info_request = CollectionInfoRequest.new(params[:collection_info_request])
    @collection_info_request.request = request
    if @collection_info_request.deliver
      # redirect_to :back
      # flash.now[:error] = nil
      flash.now[:notice] = 'Thank you for your message!'
    else
      flash.now[:error] = @collection_info_request.errors.full_messages.to_sentence
      # render :new
      render :template => "remote_content/devise_errors.js.erb"
    end
  end
end