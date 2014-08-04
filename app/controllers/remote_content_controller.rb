class RemoteContentController < ApplicationController

	def remote_info_request
		@info_request = InfoRequest.new
		@item = Item.find_by_slug!(params[:item])
	end

end
