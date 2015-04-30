class ItemDecorator < Draper::Decorator
	include Draper::LazyHelpers
  delegate_all

  def add_to_collection
  	
		# "Signed in. User has Collections. Item Available"
  	if user_signed_in? && current_user.collections.count > 0 && !model.sold
  		link_to 'Add to Collection', remote_collection_addition_path(:item => model.filemaker_id), :remote => true, title: "Add to collection ", class: 'btn btn-default'
  	
		# "Signed in. No Collections. Item Available"
  	elsif user_signed_in? && current_user.collections.count == 0 && !model.sold
  		link_to 'Create Collection', set_new_item_path(:item_id => model.filemaker_id), class: 'btn btn-default', title: 'Add to collection', method: :post, remote: false
  	
		# "Signed in. User has Collections. Item Sold."
  	elsif user_signed_in? && current_user.collections.count > 0 && model.sold
		
		# "Signed in. No Collections. Item Sold."
  	elsif user_signed_in? && current_user.collections.count == 0 && model.sold

		# "Not signed in. Item Available"
  	elsif !current_user && !model.sold
  		link_to 'Create Collection', remote_login_path, :remote => true, title: "Add to collection (Login required)", class: 'btn btn-default'
		
		# "Not signed in. Item Sold."
  	elsif !current_user && model.sold
  	end
  end

	# def default_image_url
	# 	if model.images.where(active: true).where(webcomp: true).first.present?
	# 		model.images.where(active: true).where(webcomp: true).last.url
	# 	else
	# 		"data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxOC4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgODY5IDUwMCIgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgODY5IDUwMCIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8cmVjdCBmaWxsPSIjRjFGMkYyIiB3aWR0aD0iODY5IiBoZWlnaHQ9IjUwMCIvPg0KPHRleHQgdHJhbnNmb3JtPSJtYXRyaXgoMSAwIDAgMSAyMjEuMjY4MyAyNjAuMzQ0NykiIGZpbGw9IiM2RDZFNzEiIGZvbnQtZmFtaWx5PSInT3BlblNhbnMtU2VtaWJvbGQnIiBmb250LXNpemU9IjM2Ij53ZWJjb21wIGltYWdlIG1pc3Npbmc8L3RleHQ+DQo8L3N2Zz4NCg=="
	# 	end
	# end

	def comp_image_tag
		if model.comp.present?
			# cl_image_tag(model.images.where(image_type: "Comp Web").first.filemaker_id + ".jpg", :alt => "#{model.filemaker_id} Image", class: "webcomp")
			cl_image_tag model.comp.filemaker_id + ".jpg", :color_space => :srgb, :width => :auto, :crop => :limit, :dpr => :auto, :responsive_placeholder => "#{asset_path 'detail_loading.svg'}", alt: "Item: #{model.filemaker_id}", class: "img-responsive cld-responsive"
		else
			image_tag "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxOC4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgODY5IDUwMCIgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgODY5IDUwMCIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8cmVjdCBmaWxsPSIjRjFGMkYyIiB3aWR0aD0iODY5IiBoZWlnaHQ9IjUwMCIvPg0KPHRleHQgdHJhbnNmb3JtPSJtYXRyaXgoMSAwIDAgMSAyMjEuMjY4MyAyNjAuMzQ0NykiIGZpbGw9IiM2RDZFNzEiIGZvbnQtZmFtaWx5PSInT3BlblNhbnMtU2VtaWJvbGQnIiBmb250LXNpemU9IjM2Ij53ZWJjb21wIGltYWdlIG1pc3Npbmc8L3RleHQ+DQo8L3N2Zz4NCg=="
		end
	end

	def featured_image_tag
		if model.comp.present?
			# cl_image_tag(model.images.where(image_type: "Comp Web").first.filemaker_id + ".jpg", :alt => "#{model.filemaker_id} Image", class: "webcomp")
			cl_image_tag "featured_" + model.comp.filemaker_id + ".jpg", :color_space => :srgb, :width => :auto, :crop => :limit, :dpr => :auto, :responsive_placeholder => "#{asset_path 'detail_loading.svg'}", alt: "Item: #{model.filemaker_id}", class: "img-responsive cld-responsive"
		else
			image_tag "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxOC4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgODY5IDUwMCIgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgODY5IDUwMCIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8cmVjdCBmaWxsPSIjRjFGMkYyIiB3aWR0aD0iODY5IiBoZWlnaHQ9IjUwMCIvPg0KPHRleHQgdHJhbnNmb3JtPSJtYXRyaXgoMSAwIDAgMSAyMjEuMjY4MyAyNjAuMzQ0NykiIGZpbGw9IiM2RDZFNzEiIGZvbnQtZmFtaWx5PSInT3BlblNhbnMtU2VtaWJvbGQnIiBmb250LXNpemU9IjM2Ij53ZWJjb21wIGltYWdlIG1pc3Npbmc8L3RleHQ+DQo8L3N2Zz4NCg=="
		end
	end

	def thumb_image_tag
		if model.thumb.present?
			# cl_image_tag model.thumb.filemaker_id + ".jpg", :alt => "#{model.filemaker_id} Image"
			cl_image_tag model.thumb.filemaker_id + ".jpg", :color_space => :srgb, :width => :auto, :crop => :limit, :dpr => :auto, :responsive_placeholder => "#{asset_path 'detail_loading.svg'}", alt: "Item: #{model.filemaker_id}", class: "img-responsive cld-responsive"
		else
			image_tag "detail_missing.svg"
		end
	end

	def detail_image_tag(image)
		if user_signed_in?
			link_to image.url, :target => "_blank" do
				# image_tag image.preview_url, title: 'Click for high resolution image'
				cl_image_tag image.filemaker_id + ".jpg", :color_space => :srgb, :width => 731, :crop => :limit, :dpr => :auto, :responsive_placeholder => "#{asset_path 'detail_loading.svg'}", title: 'Click for high resolution image', class: "img-responsive cld-responsive"
			end
		else
			link_to remote_login_path, :remote => true, title: "View high resolution image (Login required)" do
				# image_tag image.preview_url
				cl_image_tag image.filemaker_id + ".jpg", :color_space => :srgb, :width => 731, :crop => :limit, :dpr => :auto, :responsive_placeholder => "blank", class: "img-responsive cld-responsive"
			end
		end
	end

 	def location_calc
		if model.location == "Uptown"
			"The Carlyle"
		elsif model.location == "Downtown"
			"Greenwich Village"
		else
			link_to 'Contact us for more information', page_path('about-us')
		end
	end

	def maker_display
		case model.maker_list.size
		when 1
		  link_to(model.maker_list.first.titlecase, designer_path(model.maker_list.first))
		when 2
			link_to(model.maker_list.first.titlecase, designer_path(model.maker_list.first)) + 
			if model.designer_connector_1.present?
				" " + model.designer_connector_1 + " "
			else
				", "
			end + 
			link_to(model.maker_list.second.titlecase, designer_path(model.maker_list.second))
		when 3
			link_to(model.maker_list.first.titlecase, designer_path(model.maker_list.first)) + 
			if model.designer_connector_1.present?
				" " + model.designer_connector_1 + " "
			else
				", "
			end + 
			link_to(model.maker_list.second.titlecase, designer_path(model.maker_list.second)) + 
			if model.designer_connector_2.present?
				" " + model.designer_connector_2 + " "
			else
				", "
			end + 
			link_to(model.maker_list.third.titlecase, designer_path(model.maker_list.third))
		else
		  ""
		end
	end

	def subnav
		if model.sold
			render 'item_subnav_sold'
		else
			render 'item_subnav'
		end
	end

end
