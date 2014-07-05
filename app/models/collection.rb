class Collection < ActiveRecord::Base

	belongs_to :user
	has_many :collection_items, dependent: :delete_all
	has_many :items, :through => :collection_items

	validates_presence_of :name, :on => :create, :message => "can't be blank"
	validates_presence_of :user_id

	scope :active, -> { where(active: true) }

end
