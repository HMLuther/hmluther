class Feedback < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attribute :item
  attribute :message
  attribute :nickname,  :captcha  => true
  attribute :path
  attribute :thumb
  attribute :type

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Website Feedback",
      :to => "info@hmluther.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end