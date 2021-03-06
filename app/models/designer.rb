class Designer < ApplicationRecord

	acts_as_taggable_on :affiliate

	before_validation :generate_slug

	validates_presence_of :filemaker_id, :on => :create, :message => "can't be blank"
	validates_presence_of :name_first, :on => :create, :message => "can't be blank"
	validates :slug, uniqueness: true, presence: true

	default_scope { order('name_last ASC') }

  scope :listed, -> { where(listed: true) }

  def self.active?
    where(active: true)
  end

	def generate_slug
		self.slug ||= name_full.parameterize
	end

	def to_param
		slug
	end

	def items
		Item.tagged_with(self.slug)
	end

	def item_count
		self.items.designer_list.count
	end

	def listed_items
		ItemDecorator.decorate_collection(Item.tagged_with(self.slug).designer_list)
	end

	def name_full
		"#{name_first} #{name_last}"
	end

	def name_lf
		if self.name_last.present?
			"#{name_last}, #{name_first}"
		else
			"#{name_first}"
		end
	end

	def name_initial
		if self.name_last.present?
			self.name_last[0]
		else
			self.name_first[0]
		end
	end

end
