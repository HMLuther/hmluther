class Page < ApplicationRecord

	before_validation :generate_slug

	validates_presence_of :name, :on => :create, :message => "can't be blank"
	validates :name, uniqueness: true
	validates :slug, uniqueness: true, presence: true

	def to_param
		slug
	end

	private

	def generate_slug
		self.slug ||= name.parameterize
	end


end
