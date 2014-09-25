class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = FeedbackContact.new(params[:feedback])
    @feedback.request = request
    if @feedback.deliver
      # redirect_to :back
      # flash.now[:error] = nil
      flash.now[:notice] = 'Thank you for your feedback!'
    else
      flash.now[:error] = @feedback.errors.full_messages.to_sentence
      # render :new
      render :template => "remote_content/devise_errors.js.erb"
    end
  end
end