class Item < ActiveRecord::Base

	belongs_to :subcategory
	has_many :images

	validates_presence_of :description_short, :on => :create, :message => "can't be blank"

def default_image
	self.images.where(primary: true)
end

end
