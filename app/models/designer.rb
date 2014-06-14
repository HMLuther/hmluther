class Designer < ActiveRecord::Base

	acts_as_taggable_on :affiliate

	before_validation :generate_slug

	validates_presence_of :filemaker_id, :on => :create, :message => "can't be blank"
	validates_presence_of :name, :on => :create, :message => "can't be blank"
	validates :slug, uniqueness: true, presence: true

	default_scope { order('name ASC') }

  scope :listed, -> { where(listed: true) }

  def self.active?
    where(active: true)
  end

  def container_size
  	self.items.count * 883
  end

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
