class UserMailer < ActionMailer::Base
  default from: "sales@hmluther.com"

  def new_user(user)
    @user = user
    # mail to: user.email, subject: "Hello!"
    mail to: "todd@decibeldesign.com", subject: "Hello!"
  end

  def share_item(user, item, receipient)
  	@item = item
  	@user = user
  	mail to: receipient, subject: "Someone has shared this item with you"
  end
end