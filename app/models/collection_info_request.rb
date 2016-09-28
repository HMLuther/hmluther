class CollectionInfoRequest < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attribute :collection_name
  attribute :collection_url
  attribute :item_ids
  attribute :message
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Collection Information Request",
      :to => ENV["HML_EMAIL"],
      :from => ENV["MANDRILL_USERNAME"]
    }
  end
end