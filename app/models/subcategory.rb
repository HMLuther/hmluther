class Subcategory < ActiveRecord::Base

	belongs_to :category

	validates_presence_of :name, :on => :create, :message => "can't be blank"

end
