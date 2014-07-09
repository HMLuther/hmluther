class UserMailerPreview < ActionMailer::Preview

  def new_user
    user = User.first
    UserMailer.new_user(user)
  end

  def share_item
  	item = Item.first
  	receipient = "sales@example.com"
  	user = User.last
  	UserMailer.share_item(user, item, receipient)
  end

end