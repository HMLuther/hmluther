class RemoteContentController < ApplicationController

	before_action :set_item, only: [:remote_collection_addition, :remote_info_request, :remote_share_item]

	def remote_collection_addition
		@collections = current_user.collections.active
	end

	def remote_feedback
		@feedback = Feedback.new
	end

	def remote_info_request
		@info_request = InfoRequest.new
	end

	def remote_share_collection
		@collection = Collection.find(params[:collection])
		@share = Share.new
	end

	def remote_share_item
		@share = Share.new
	end


	private

		def set_item
			@item = Item.find_by_slug!(params[:item])
		end

end
