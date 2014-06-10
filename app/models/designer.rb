class Designer < ActiveRecord::Base

	before_validation :generate_slug

	validates_presence_of :filemaker_id, :on => :create, :message => "can't be blank"
	validates_presence_of :name, :on => :create, :message => "can't be blank"
	validates :slug, uniqueness: true, presence: true

  scope :listed, -> { where('self.item_count: > 3') }

	def generate_slug
		self.slug ||= name.parameterize
	end

	def to_param
		slug
	end

	def items
		Item.tagged_with(self.slug)
	end

	def item_count
		self.items.count
	end

end
