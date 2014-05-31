class Subcategory < ActiveRecord::Base

	belongs_to :category
	has_many :items

	validates_presence_of :name, :on => :create, :message => "can't be blank"
	validates :slug, uniqueness: true, presence: true,
                 exclusion: {in: %w[signup login]}

	before_validation :generate_slug

	def generate_slug
		self.slug ||= name.parameterize
	end

	def to_param
		slug
	end

	def container_size
		self.items.count * 883
	end

end
