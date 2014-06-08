class Designer < ActiveRecord::Base

	before_validation :generate_slug

	validates_presence_of :name, :on => :create, :message => "can't be blank"
	validates :slug, uniqueness: true, presence: true,
                 exclusion: {in: %w[signup login]}

	def generate_slug
		self.slug ||= name.parameterize
	end

	def to_param
		slug
	end

end
