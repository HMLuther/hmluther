class Item < ActiveRecord::Base

	belongs_to :subcategory
	has_many :images

	validates_presence_of :description_short, :on => :create, :message => "can't be blank"

	scope :featured, -> { where(featured: true) }

def default_image_url
	self.images.where(primary: true).first.url
end

end
