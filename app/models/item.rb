class Item < ActiveRecord::Base

	is_impressionable

	acts_as_taggable_on :category, :maker

	before_validation :generate_slug

	has_many :images, primary_key: "filemaker_id", dependent: :destroy
	has_many :collection_items, primary_key: "filemaker_id"
	has_many :collections, :through => :collection_items, primary_key: "filemaker_id"

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

	def thumb_image_url
		if self.images.where(image_type: "Thumbnail").first.present?
			self.images.where(thumb: true).first.url
			# cl_image_tag(model.images.where(image_type: "Thumbnail").first.filemaker_id + ".jpg", :alt => "#{model.filemaker_id} Image", class: "webcomp")
		else
			"data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxOC4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgODY5IDUwMCIgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgODY5IDUwMCIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8cmVjdCBmaWxsPSIjRjFGMkYyIiB3aWR0aD0iODY5IiBoZWlnaHQ9IjUwMCIvPg0KPGc+DQoJPHBhdGggZmlsbD0iIzZENkU3MSIgZD0iTTI0MC4yLDI2MC4zbC0yLjUtOS4xYy0wLjMtMS0wLjktMy4yLTEuNy02LjdoLTAuMmMtMC43LDMuMi0xLjIsNS40LTEuNiw2LjdsLTIuNiw5aC00LjZsLTUuNC0xOS40aDQuMg0KCQlsMi41LDkuNmMwLjYsMi40LDEsNC40LDEuMiw2LjFoMC4xYzAuMS0wLjksMC4zLTEuOCwwLjUtMi45czAuNC0xLjksMC42LTIuNWwzLTEwLjJoNC41bDIuOSwxMC4yYzAuMiwwLjYsMC40LDEuNSwwLjcsMi42DQoJCXMwLjQsMi4xLDAuNSwyLjhoMC4xYzAuMi0xLjQsMC42LTMuNSwxLjItNmwyLjUtOS42aDQuMWwtNS41LDE5LjRIMjQwLjJ6Ii8+DQoJPHBhdGggZmlsbD0iIzZENkU3MSIgZD0iTTI2Mi4xLDI2MC43Yy0zLDAtNS40LTAuOS03LjEtMi42cy0yLjYtNC4yLTIuNi03LjNjMC0zLjIsMC44LTUuNywyLjQtNy41czMuOC0yLjcsNi41LTIuNw0KCQljMi42LDAsNC42LDAuOCw2LjEsMi4zczIuMiwzLjcsMi4yLDYuNHYyLjJoLTEzYzAuMSwxLjksMC42LDMuMywxLjUsNC40czIuMywxLjUsNC4xLDEuNWMxLjEsMCwyLjItMC4xLDMuMi0wLjNzMi4xLTAuNiwzLjItMS4xDQoJCXYzLjRjLTEsMC41LTIsMC44LTMuMSwxUzI2My40LDI2MC43LDI2Mi4xLDI2MC43eiBNMjYxLjQsMjQzLjdjLTEuMywwLTIuNCwwLjQtMy4yLDEuMnMtMS4zLDItMS40LDMuNmg4LjhjMC0xLjYtMC40LTIuOC0xLjItMy42DQoJCVMyNjIuNywyNDMuNywyNjEuNCwyNDMuN3oiLz4NCgk8cGF0aCBmaWxsPSIjNkQ2RTcxIiBkPSJNMjg0LjMsMjQwLjZjMi40LDAsNC4zLDAuOSw1LjcsMi42czIsNC4yLDIsNy40YzAsMy4yLTAuNyw1LjctMi4xLDcuNHMtMy4zLDIuNy01LjcsMi43DQoJCWMtMi41LDAtNC40LTAuOS01LjctMi43aC0wLjNsLTAuOCwyLjNoLTMuMVYyMzNoNC4xdjYuNWMwLDAuNSwwLDEuMi0wLjEsMi4xcy0wLjEsMS42LTAuMSwxLjhoMC4yDQoJCUMyNzkuOCwyNDEuNSwyODEuNywyNDAuNiwyODQuMywyNDAuNnogTTI4My4yLDI0My45Yy0xLjcsMC0yLjksMC41LTMuNiwxLjVzLTEuMSwyLjYtMS4xLDQuOXYwLjNjMCwyLjQsMC40LDQuMSwxLjEsNS4xDQoJCXMyLDEuNiwzLjcsMS42YzEuNSwwLDIuNi0wLjYsMy4zLTEuN3MxLjEtMi44LDEuMS01QzI4Ny44LDI0Ni4xLDI4Ni4zLDI0My45LDI4My4yLDI0My45eiIvPg0KCTxwYXRoIGZpbGw9IiM2RDZFNzEiIGQ9Ik0zMDQuNiwyNjAuN2MtMi45LDAtNS4yLTAuOS02LjctMi42cy0yLjMtNC4yLTIuMy03LjRjMC0zLjMsMC44LTUuOCwyLjQtNy41czMuOS0yLjYsNi45LTIuNg0KCQljMi4xLDAsMy45LDAuNCw1LjUsMS4xbC0xLjIsMy4zYy0xLjctMC43LTMuMi0xLTQuMy0xYy0zLjQsMC01LDIuMi01LDYuN2MwLDIuMiwwLjQsMy44LDEuMyw0LjlzMi4xLDEuNiwzLjcsMS42DQoJCWMxLjgsMCwzLjYtMC41LDUuMi0xLjR2My42Yy0wLjcsMC40LTEuNSwwLjctMi40LDAuOVMzMDUuOCwyNjAuNywzMDQuNiwyNjAuN3oiLz4NCgk8cGF0aCBmaWxsPSIjNkQ2RTcxIiBkPSJNMzMxLjksMjUwLjZjMCwzLjItMC44LDUuNy0yLjQsNy40cy0zLjksMi43LTYuOCwyLjdjLTEuOCwwLTMuNC0wLjQtNC44LTEuMnMtMi41LTItMy4yLTMuNQ0KCQlzLTEuMS0zLjMtMS4xLTUuM2MwLTMuMiwwLjgtNS42LDIuNC03LjRzMy45LTIuNyw2LjgtMi43YzIuOCwwLDUsMC45LDYuNywyLjdTMzMxLjksMjQ3LjUsMzMxLjksMjUwLjZ6IE0zMTcuNywyNTAuNg0KCQljMCw0LjUsMS43LDYuNyw1LDYuN2MzLjMsMCw0LjktMi4yLDQuOS02LjdjMC00LjQtMS43LTYuNy01LTYuN2MtMS43LDAtMywwLjYtMy44LDEuN1MzMTcuNywyNDguNCwzMTcuNywyNTAuNnoiLz4NCgk8cGF0aCBmaWxsPSIjNkQ2RTcxIiBkPSJNMzUzLDI2MC4zaC00LjF2LTEyYzAtMS41LTAuMy0yLjYtMC44LTMuM3MtMS40LTEuMS0yLjYtMS4xYy0xLjYsMC0yLjgsMC41LTMuNSwxLjZzLTEuMSwyLjgtMS4xLDUuMnY5LjcNCgkJaC00LjF2LTE5LjRoMy4ybDAuNiwyLjVoMC4yYzAuNS0wLjksMS4zLTEuNiwyLjMtMi4xczIuMi0wLjgsMy40LTAuOGMzLDAsNSwxLDUuOSwzLjFoMC4zYzAuNi0xLDEuNC0xLjcsMi40LTIuMnMyLjItMC44LDMuNi0wLjgNCgkJYzIuMywwLDQsMC42LDUuMSwxLjhzMS42LDMsMS42LDUuNHYxMi43aC00LjF2LTEyYzAtMS41LTAuMy0yLjYtMC45LTMuM3MtMS40LTEuMS0yLjYtMS4xYy0xLjYsMC0yLjgsMC41LTMuNSwxLjVTMzUzLDI0OCwzNTMsMjUwDQoJCVYyNjAuM3oiLz4NCgk8cGF0aCBmaWxsPSIjNkQ2RTcxIiBkPSJNMzgwLjksMjYwLjdjLTIuNSwwLTQuNC0wLjktNS43LTIuN2gtMC4yYzAuMiwxLjYsMC4yLDIuNiwwLjIsM3Y4SDM3MXYtMjguMWgzLjNjMC4xLDAuNCwwLjMsMS4yLDAuNiwyLjYNCgkJaDAuMmMxLjMtMiwzLjItMyw1LjgtM2MyLjQsMCw0LjMsMC45LDUuNywyLjZzMiw0LjIsMiw3LjRzLTAuNyw1LjctMi4xLDcuNFMzODMuMywyNjAuNywzODAuOSwyNjAuN3ogTTM3OS45LDI0My45DQoJCWMtMS42LDAtMi44LDAuNS0zLjYsMS40cy0xLjEsMi41LTEuMSw0LjZ2MC42YzAsMi40LDAuNCw0LjEsMS4xLDUuMXMyLDEuNiwzLjcsMS42YzEuNCwwLDIuNS0wLjYsMy4zLTEuOHMxLjItMi44LDEuMi01DQoJCWMwLTIuMi0wLjQtMy44LTEuMi00LjlTMzgxLjQsMjQzLjksMzc5LjksMjQzLjl6Ii8+DQoJPHBhdGggZmlsbD0iIzZENkU3MSIgZD0iTTQwMi42LDIzNS44YzAtMC43LDAuMi0xLjMsMC42LTEuN3MxLTAuNiwxLjctMC42YzAuNywwLDEuMywwLjIsMS43LDAuNnMwLjYsMSwwLjYsMS43DQoJCWMwLDAuNy0wLjIsMS4zLTAuNiwxLjdzLTEsMC42LTEuNywwLjZjLTAuOCwwLTEuMy0wLjItMS43LTAuNlM0MDIuNiwyMzYuNSw0MDIuNiwyMzUuOHogTTQwNi45LDI2MC4zaC00LjF2LTE5LjRoNC4xVjI2MC4zeiIvPg0KCTxwYXRoIGZpbGw9IiM2RDZFNzEiIGQ9Ik00MjkuMiwyNjAuM2gtNC4xdi0xMmMwLTEuNS0wLjMtMi42LTAuOC0zLjNzLTEuNC0xLjEtMi42LTEuMWMtMS42LDAtMi44LDAuNS0zLjUsMS42cy0xLjEsMi44LTEuMSw1LjINCgkJdjkuN2gtNC4xdi0xOS40aDMuMmwwLjYsMi41aDAuMmMwLjUtMC45LDEuMy0xLjYsMi4zLTIuMXMyLjItMC44LDMuNC0wLjhjMywwLDUsMSw1LjksMy4xaDAuM2MwLjYtMSwxLjQtMS43LDIuNC0yLjINCgkJczIuMi0wLjgsMy42LTAuOGMyLjMsMCw0LDAuNiw1LjEsMS44czEuNiwzLDEuNiw1LjR2MTIuN2gtNC4xdi0xMmMwLTEuNS0wLjMtMi42LTAuOS0zLjNzLTEuNS0xLjEtMi42LTEuMWMtMS42LDAtMi44LDAuNS0zLjUsMS41DQoJCXMtMS4xLDIuNS0xLjEsNC42VjI2MC4zeiIvPg0KCTxwYXRoIGZpbGw9IiM2RDZFNzEiIGQ9Ik00NTkuNCwyNjAuM2wtMC44LTIuN2gtMC4xYy0wLjksMS4yLTEuOSwyLTIuOCwyLjRzLTIuMiwwLjYtMy43LDAuNmMtMS45LDAtMy40LTAuNS00LjUtMS41DQoJCXMtMS42LTIuNS0xLjYtNC40YzAtMiwwLjctMy41LDIuMi00LjVzMy44LTEuNiw2LjgtMS43bDMuNC0wLjF2LTFjMC0xLjItMC4zLTIuMi0wLjktMi44cy0xLjUtMC45LTIuNy0wLjljLTEsMC0yLDAuMS0yLjksMC40DQoJCXMtMS44LDAuNi0yLjYsMWwtMS4zLTNjMS4xLTAuNiwyLjItMSwzLjUtMS4zczIuNC0wLjQsMy42LTAuNGMyLjUsMCw0LjMsMC41LDUuNiwxLjZzMS45LDIuOCwxLjksNS4xdjEzLjFINDU5LjR6IE00NTMuMywyNTcuNQ0KCQljMS41LDAsMi43LTAuNCwzLjYtMS4zczEuNC0yLDEuNC0zLjV2LTEuN2wtMi41LDAuMWMtMS45LDAuMS0zLjQsMC40LTQuMiwxcy0xLjMsMS41LTEuMywyLjdjMCwwLjksMC4zLDEuNSwwLjgsMg0KCQlTNDUyLjMsMjU3LjUsNDUzLjMsMjU3LjV6Ii8+DQoJPHBhdGggZmlsbD0iIzZENkU3MSIgZD0iTTQ4NC42LDI0MC45djIuM2wtMy4zLDAuNmMwLjMsMC40LDAuNiwwLjksMC44LDEuNXMwLjMsMS4yLDAuMywxLjljMCwyLTAuNywzLjYtMi4xLDQuN3MtMy4zLDEuNy01LjcsMS43DQoJCWMtMC42LDAtMS4yLDAtMS43LTAuMWMtMC45LDAuNi0xLjMsMS4yLTEuMywxLjljMCwwLjQsMC4yLDAuOCwwLjYsMXMxLjIsMC4zLDIuMywwLjNoMy40YzIuMSwwLDMuOCwwLjUsNC45LDEuNHMxLjcsMi4yLDEuNyw0DQoJCWMwLDIuMi0wLjksMy45LTIuNyw1LjFzLTQuNCwxLjgtNy45LDEuOGMtMi42LDAtNC43LTAuNS02LjEtMS40cy0yLjEtMi4zLTIuMS00YzAtMS4yLDAuNC0yLjIsMS4xLTNzMS44LTEuNCwzLjItMS43DQoJCWMtMC42LTAuMi0xLTAuNi0xLjQtMS4xcy0wLjUtMS4xLTAuNS0xLjZjMC0wLjcsMC4yLTEuMywwLjYtMS44czEtMSwxLjgtMS41Yy0xLTAuNC0xLjgtMS4xLTIuNS0yLjFzLTAuOS0yLjEtMC45LTMuNA0KCQljMC0yLjEsMC43LTMuNywyLTQuOXMzLjItMS43LDUuNy0xLjdjMC42LDAsMS4xLDAsMS43LDAuMXMxLjEsMC4yLDEuNCwwLjJINDg0LjZ6IE00NjkuMywyNjMuNGMwLDAuOSwwLjQsMS42LDEuMiwyLjENCgkJczEuOSwwLjcsMy40LDAuN2MyLjIsMCwzLjktMC4zLDUtMXMxLjctMS41LDEuNy0yLjZjMC0wLjgtMC4zLTEuNC0wLjktMS44cy0xLjctMC41LTMuNC0wLjVoLTMuMWMtMS4yLDAtMi4xLDAuMy0yLjgsMC44DQoJCVM0NjkuMywyNjIuNCw0NjkuMywyNjMuNHogTTQ3MS4xLDI0Ny4yYzAsMS4yLDAuMywyLjIsMC45LDIuOHMxLjUsMSwyLjcsMWMyLjQsMCwzLjYtMS4zLDMuNi0zLjhjMC0xLjMtMC4zLTIuMi0wLjktMi45DQoJCXMtMS41LTEtMi43LTFjLTEuMiwwLTIuMSwwLjMtMi43LDFTNDcxLjEsMjQ1LjksNDcxLjEsMjQ3LjJ6Ii8+DQoJPHBhdGggZmlsbD0iIzZENkU3MSIgZD0iTTQ5Ni43LDI2MC43Yy0zLDAtNS40LTAuOS03LjEtMi42cy0yLjYtNC4yLTIuNi03LjNjMC0zLjIsMC44LTUuNywyLjQtNy41czMuOC0yLjcsNi41LTIuNw0KCQljMi42LDAsNC42LDAuOCw2LjEsMi4zczIuMiwzLjcsMi4yLDYuNHYyLjJoLTEzYzAuMSwxLjksMC42LDMuMywxLjUsNC40czIuMywxLjUsNC4xLDEuNWMxLjEsMCwyLjItMC4xLDMuMi0wLjNzMi4xLTAuNiwzLjItMS4xDQoJCXYzLjRjLTEsMC41LTIsMC44LTMuMSwxUzQ5OCwyNjAuNyw0OTYuNywyNjAuN3ogTTQ5NS45LDI0My43Yy0xLjMsMC0yLjQsMC40LTMuMiwxLjJzLTEuMywyLTEuNCwzLjZoOC44YzAtMS42LTAuNC0yLjgtMS4yLTMuNg0KCQlTNDk3LjIsMjQzLjcsNDk1LjksMjQzLjd6Ii8+DQoJPHBhdGggZmlsbD0iIzZENkU3MSIgZD0iTTUzNC43LDI2MC4zaC00LjF2LTEyYzAtMS41LTAuMy0yLjYtMC44LTMuM3MtMS40LTEuMS0yLjYtMS4xYy0xLjYsMC0yLjgsMC41LTMuNSwxLjZzLTEuMSwyLjgtMS4xLDUuMg0KCQl2OS43aC00LjF2LTE5LjRoMy4ybDAuNiwyLjVoMC4yYzAuNS0wLjksMS4zLTEuNiwyLjMtMi4xczIuMi0wLjgsMy40LTAuOGMzLDAsNSwxLDUuOSwzLjFoMC4zYzAuNi0xLDEuNC0xLjcsMi40LTIuMg0KCQlzMi4yLTAuOCwzLjYtMC44YzIuMywwLDQsMC42LDUuMSwxLjhzMS42LDMsMS42LDUuNHYxMi43aC00LjF2LTEyYzAtMS41LTAuMy0yLjYtMC45LTMuM3MtMS41LTEuMS0yLjYtMS4xYy0xLjYsMC0yLjgsMC41LTMuNSwxLjUNCgkJcy0xLjEsMi41LTEuMSw0LjZWMjYwLjN6Ii8+DQoJPHBhdGggZmlsbD0iIzZENkU3MSIgZD0iTTU1Mi40LDIzNS44YzAtMC43LDAuMi0xLjMsMC42LTEuN3MxLTAuNiwxLjctMC42YzAuNywwLDEuMywwLjIsMS43LDAuNnMwLjYsMSwwLjYsMS43DQoJCWMwLDAuNy0wLjIsMS4zLTAuNiwxLjdzLTEsMC42LTEuNywwLjZjLTAuOCwwLTEuMy0wLjItMS43LTAuNlM1NTIuNCwyMzYuNSw1NTIuNCwyMzUuOHogTTU1Ni44LDI2MC4zaC00LjF2LTE5LjRoNC4xVjI2MC4zeiIvPg0KCTxwYXRoIGZpbGw9IiM2RDZFNzEiIGQ9Ik01NzUuOCwyNTQuOGMwLDEuOS0wLjcsMy40LTIuMSw0LjRzLTMuNCwxLjUtNS45LDEuNWMtMi42LDAtNC43LTAuNC02LjItMS4yVjI1NmMyLjMsMS4xLDQuNCwxLjYsNi40LDEuNg0KCQljMi41LDAsMy44LTAuOCwzLjgtMi4zYzAtMC41LTAuMS0wLjktMC40LTEuMnMtMC43LTAuNy0xLjQtMXMtMS41LTAuOC0yLjctMS4yYy0yLjItMC45LTMuOC0xLjctNC41LTIuNnMtMS4yLTItMS4yLTMuNA0KCQljMC0xLjcsMC43LTMsMi0zLjlzMy4yLTEuNCw1LjUtMS40YzIuMywwLDQuNCwwLjUsNi41LDEuNGwtMS4zLDMuMWMtMi4xLTAuOS0zLjktMS4zLTUuMy0xLjNjLTIuMiwwLTMuMywwLjYtMy4zLDEuOQ0KCQljMCwwLjYsMC4zLDEuMSwwLjksMS41czEuOCwxLDMuNywxLjdjMS42LDAuNiwyLjgsMS4yLDMuNSwxLjdzMS4zLDEuMSwxLjYsMS44UzU3NS44LDI1My45LDU3NS44LDI1NC44eiIvPg0KCTxwYXRoIGZpbGw9IiM2RDZFNzEiIGQ9Ik01OTMuMywyNTQuOGMwLDEuOS0wLjcsMy40LTIuMSw0LjRzLTMuNCwxLjUtNS45LDEuNWMtMi42LDAtNC43LTAuNC02LjItMS4yVjI1NmMyLjMsMS4xLDQuNCwxLjYsNi40LDEuNg0KCQljMi41LDAsMy44LTAuOCwzLjgtMi4zYzAtMC41LTAuMS0wLjktMC40LTEuMnMtMC43LTAuNy0xLjQtMXMtMS41LTAuOC0yLjctMS4yYy0yLjItMC45LTMuOC0xLjctNC41LTIuNnMtMS4yLTItMS4yLTMuNA0KCQljMC0xLjcsMC43LTMsMi0zLjlzMy4yLTEuNCw1LjUtMS40YzIuMywwLDQuNCwwLjUsNi41LDEuNGwtMS4zLDMuMWMtMi4xLTAuOS0zLjktMS4zLTUuMy0xLjNjLTIuMiwwLTMuMywwLjYtMy4zLDEuOQ0KCQljMCwwLjYsMC4zLDEuMSwwLjksMS41czEuOCwxLDMuNywxLjdjMS42LDAuNiwyLjgsMS4yLDMuNSwxLjdzMS4zLDEuMSwxLjYsMS44UzU5My4zLDI1My45LDU5My4zLDI1NC44eiIvPg0KCTxwYXRoIGZpbGw9IiM2RDZFNzEiIGQ9Ik01OTcuNSwyMzUuOGMwLTAuNywwLjItMS4zLDAuNi0xLjdzMS0wLjYsMS43LTAuNmMwLjcsMCwxLjMsMC4yLDEuNywwLjZzMC42LDEsMC42LDEuNw0KCQljMCwwLjctMC4yLDEuMy0wLjYsMS43cy0xLDAuNi0xLjcsMC42Yy0wLjgsMC0xLjMtMC4yLTEuNy0wLjZTNTk3LjUsMjM2LjUsNTk3LjUsMjM1Ljh6IE02MDEuOSwyNjAuM2gtNC4xdi0xOS40aDQuMVYyNjAuM3oiLz4NCgk8cGF0aCBmaWxsPSIjNkQ2RTcxIiBkPSJNNjI0LjksMjYwLjNoLTQuMXYtMTJjMC0xLjUtMC4zLTIuNi0wLjktMy40cy0xLjYtMS4xLTIuOS0xLjFjLTEuNywwLTMsMC41LTMuOCwxLjVzLTEuMiwyLjgtMS4yLDUuMnY5LjcNCgkJaC00LjF2LTE5LjRoMy4ybDAuNiwyLjVoMC4yYzAuNi0wLjksMS40LTEuNiwyLjUtMi4xczIuMy0wLjgsMy42LTAuOGM0LjcsMCw3LDIuNCw3LDcuMVYyNjAuM3oiLz4NCgk8cGF0aCBmaWxsPSIjNkQ2RTcxIiBkPSJNNjQ3LjEsMjQwLjl2Mi4zbC0zLjMsMC42YzAuMywwLjQsMC42LDAuOSwwLjgsMS41czAuMywxLjIsMC4zLDEuOWMwLDItMC43LDMuNi0yLjEsNC43cy0zLjMsMS43LTUuNywxLjcNCgkJYy0wLjYsMC0xLjIsMC0xLjctMC4xYy0wLjksMC42LTEuMywxLjItMS4zLDEuOWMwLDAuNCwwLjIsMC44LDAuNiwxczEuMiwwLjMsMi4zLDAuM2gzLjRjMi4xLDAsMy44LDAuNSw0LjksMS40czEuNywyLjIsMS43LDQNCgkJYzAsMi4yLTAuOSwzLjktMi43LDUuMXMtNC40LDEuOC03LjksMS44Yy0yLjYsMC00LjctMC41LTYuMS0xLjRzLTIuMS0yLjMtMi4xLTRjMC0xLjIsMC40LTIuMiwxLjEtM3MxLjgtMS40LDMuMi0xLjcNCgkJYy0wLjYtMC4yLTEtMC42LTEuNC0xLjFzLTAuNS0xLjEtMC41LTEuNmMwLTAuNywwLjItMS4zLDAuNi0xLjhzMS0xLDEuOC0xLjVjLTEtMC40LTEuOC0xLjEtMi41LTIuMXMtMC45LTIuMS0wLjktMy40DQoJCWMwLTIuMSwwLjctMy43LDItNC45czMuMi0xLjcsNS43LTEuN2MwLjYsMCwxLjEsMCwxLjcsMC4xczEuMSwwLjIsMS40LDAuMkg2NDcuMXogTTYzMS44LDI2My40YzAsMC45LDAuNCwxLjYsMS4yLDIuMQ0KCQlzMS45LDAuNywzLjQsMC43YzIuMiwwLDMuOS0wLjMsNS0xczEuNy0xLjUsMS43LTIuNmMwLTAuOC0wLjMtMS40LTAuOS0xLjhzLTEuNy0wLjUtMy40LTAuNWgtMy4xYy0xLjIsMC0yLjEsMC4zLTIuOCwwLjgNCgkJUzYzMS44LDI2Mi40LDYzMS44LDI2My40eiBNNjMzLjYsMjQ3LjJjMCwxLjIsMC4zLDIuMiwwLjksMi44czEuNSwxLDIuNywxYzIuNCwwLDMuNi0xLjMsMy42LTMuOGMwLTEuMy0wLjMtMi4yLTAuOS0yLjkNCgkJcy0xLjUtMS0yLjctMWMtMS4yLDAtMi4xLDAuMy0yLjcsMVM2MzMuNiwyNDUuOSw2MzMuNiwyNDcuMnoiLz4NCjwvZz4NCjwvc3ZnPg0K"
		end
	end

end
