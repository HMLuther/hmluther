class CollectionItem < ActiveRecord::Base

	belongs_to :collection
	belongs_to :item, :class_name => "Item", :foreign_key => "item_id", primary_key: :filemaker_id

	validates_presence_of :collection_id
	validates_presence_of :item_id

	scope :active, -> { where(active: true) }
	scope :inactive, -> { where(active: false) }

end
