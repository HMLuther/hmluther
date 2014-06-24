class Item < ActiveRecord::Base

	acts_as_taggable_on :category, :maker

	before_validation :generate_slug

	has_many :images, primary_key: "filemaker_id"
	has_many :collection_items
	has_many :collections, :through => :collection_items

	validates_presence_of :description_short, :on => :create, :message => "can't be blank"
	validates_presence_of :filemaker_id, :on => :create, :message => "can't be blank"
	validates :slug, uniqueness: true, presence: true

	scope :category_list, -> { where(listed_category: true) }
	scope :designer_list, -> { where(listed_designer: true) }
	scope :featured, -> { where(featured: true) }

	def generate_slug
		self.slug ||= filemaker_id.parameterize
	end

	def to_param
		slug
	end

	def default_image_url
		if self.images.where(webcomp: true).first.present?
			self.images.where(webcomp: true).first.url
		else
			"data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxOC4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgODY5IDUwMCIgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgODY5IDUwMCIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8cmVjdCBmaWxsPSIjRjFGMkYyIiB3aWR0aD0iODY5IiBoZWlnaHQ9IjUwMCIvPg0KPHRleHQgdHJhbnNmb3JtPSJtYXRyaXgoMSAwIDAgMSAyMjEuMjY4MyAyNjAuMzQ0NykiIGZpbGw9IiM2RDZFNzEiIGZvbnQtZmFtaWx5PSInT3BlblNhbnMtU2VtaWJvbGQnIiBmb250LXNpemU9IjM2Ij53ZWJjb21wIGltYWdlIG1pc3Npbmc8L3RleHQ+DQo8L3N2Zz4NCg=="
		end
	end

	def thumb_image_url
		if self.images.where(thumb: true).first.present?
			self.images.where(thumb: true).first.url
		else
			"data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxOC4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgMjUwIDI1MCIgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgMjUwIDI1MCIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8cmVjdCBmaWxsPSIjRDFEM0Q0IiB3aWR0aD0iMjUwIiBoZWlnaHQ9IjI1MCIvPg0KPHRleHQgdHJhbnNmb3JtPSJtYXRyaXgoMSAwIDAgMSA1MS4wMDkxIDExOS40NzM4KSI+PHRzcGFuIHg9IjAiIHk9IjAiIGZpbGw9IiM5Mzk1OTgiIGZvbnQtZmFtaWx5PSInT3BlblNhbnMtU2VtaWJvbGQnIiBmb250LXNpemU9IjE4Ij50aHVtYm5haWwgaW1hZ2U8L3RzcGFuPjx0c3BhbiB4PSI0MC45IiB5PSIyMS42IiBmaWxsPSIjOTM5NTk4IiBmb250LWZhbWlseT0iJ09wZW5TYW5zLVNlbWlib2xkJyIgZm9udC1zaXplPSIxOCI+bWlzc2luZzwvdHNwYW4+PC90ZXh0Pg0KPC9zdmc+DQo="
		end
	end

	def tearsheet_url
		if self.images.where("file_type = 'pdf'").first.present?
			self.images.where("file_type = 'pdf'").first.url
		end
	end

end
