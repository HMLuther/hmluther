class Share < MailForm::Base

  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attribute :collection_name
  attribute :description
  attribute :item
  attribute :message
  attribute :nickname,  :captcha  => true
  attribute :path
  attribute :recipient, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :thumb
  attribute :type

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    if self.type == "share_item"
      @subject = "#{name} shared an item with you"
    elsif self.type == "share_collection"
      @subject = "#{name} shared a collection with you"
    end
    {
      :subject => @subject,
      :to => "#{recipient}",
      :from => %("#{name}" <#{email}>)
    }
  end

end