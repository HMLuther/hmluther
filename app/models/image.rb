class Image < ActiveRecord::Base

	before_validation :generate_slug

	belongs_to :item, primary_key: "filemaker_id"

	validates_presence_of :filemaker_id, :on => :create, :message => "can't be blank"
	validates :slug, uniqueness: true, presence: true

	scope :active, -> { where(active: true) }
	scope :show_list, -> { where(thumb: false).where(webcomp: false).where("image_type != 'TS'") }

	def generate_slug
		self.slug ||= filemaker_id.parameterize
	end

	def to_param
		slug
	end

end
