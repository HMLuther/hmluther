class Feedback < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attribute :message
  attribute :nickname,  :captcha  => true
  attribute :type

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Website Feedback",
      :to => ENV["HML_EMAIL"],
      :from => ENV["MANDRILL_USERNAME"]
    }
  end
end