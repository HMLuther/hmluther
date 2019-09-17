class Image < ApplicationRecord

	before_validation :generate_slug

	belongs_to :item, primary_key: "filemaker_id"

	validates_presence_of :filemaker_id, :on => :create, :message => "can't be blank"
	validates :slug, uniqueness: true, presence: true

	# scope :active, -> { where(active: true) }
	# scope :show_list, -> { where(active: true).where(thumb: false).where(webcomp: false).where("image_type != 'TS'") }
	scope :detail_images, -> { where(image_type: "Detail") }

	def generate_slug
		self.slug ||= filemaker_id.parameterize
	end

	def to_param
		slug
	end

	def url
		if image_type == "Tearsheet"
			"http://res.cloudinary.com/" + ENV['CLOUDINARY'] + "/raw/upload/" + self.filemaker_id + ".pdf"
		else
			"http://res.cloudinary.com/" + ENV['CLOUDINARY'] + "/image/upload/" + self.filemaker_id + ".jpg"
		end
	end

end
