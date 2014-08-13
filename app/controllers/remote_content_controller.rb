class RemoteContentController < ApplicationController

	def remote_info_request
		@item = Item.find_by_slug!(params[:item])
		@info_request = InfoRequest.new
	end

	def remote_share_collection
		@collection = Collection.find(params[:collection])
		@share = Share.new
	end

	def remote_share_item
		@item = Item.find_by_slug!(params[:item])
		@share = Share.new
	end

end
