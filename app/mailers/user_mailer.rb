class UserMailer < ActionMailer::Base
  include Rails.application.routes.url_helpers
  default from: "info@hmluther.com"

  def new_user(user)
    @user = user
    # mail to: user.email, subject: "Hello!"
    mail to: "todd@decibeldesign.com", subject: "Hello!"
  end

  def share_item(user, item, receipient)
  	@item = item
  	@user = user
  	mail to: receipient, subject: "#{@user.name} has shared an item with you"
  end

  def welcome(user, item, receipient)

  end

end