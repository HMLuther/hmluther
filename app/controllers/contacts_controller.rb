class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      # redirect_to :back
      # flash.now[:error] = nil
      flash.now[:notice] = 'Thank you for your message!'
    else
      flash.now[:error] = @contact.errors.full_messages.to_sentence
      # render :new
      render :template => "contacts/contact_errors.js.erb"
    end
  end
end