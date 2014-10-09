class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :collections

  validates_presence_of :country, :message => "can't be blank"
  validates_presence_of :email, :message => "can't be blank"
  validates_presence_of :first_name, :message => "can't be blank"
  validates_presence_of :last_name, :message => "can't be blank"
  validates_presence_of :password, :message => "can't be blank"
  validates_presence_of :zip, :message => "can't be blank"

  def set_default_role
    self.role ||= :user
  end

  def name
    "#{first_name} #{last_name}"
  end

end
