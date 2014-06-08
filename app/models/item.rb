class Item < ActiveRecord::Base

	acts_as_taggable_on :category, :maker

	before_validation :generate_slug

	belongs_to :subcategory
	has_many :images

	validates_presence_of :description_short, :on => :create, :message => "can't be blank"
	validates :slug, uniqueness: true, presence: true,
                 exclusion: {in: %w[signup login]}

	scope :featured, -> { where(featured: true) }

	def generate_slug
		self.slug ||= filemaker_id.parameterize
	end

	def to_param
		slug
	end

	def default_image_url
		if self.images.where(primary: true).first.present?
			self.images.where(primary: true).first.url
		else
			"No Images"
		end
	end

end
