class Collection < ActiveRecord::Base

	belongs_to :user

	validates_presence_of :name, :on => :create, :message => "can't be blank"
	validates_presence_of :user_id

end
