class Item < ActiveRecord::Base

	belongs_to :subcategory

	validates_presence_of :description_short, :on => :create, :message => "can't be blank"

end
