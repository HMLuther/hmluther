class ItemDecorator < Draper::Decorator
	include Draper::LazyHelpers
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

	def default_image_url
		if model.images.where(webcomp: true).first.present?
			model.images.where(webcomp: true).first.url
		else
			"data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxOC4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkxheWVyXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB2aWV3Qm94PSIwIDAgODY5IDUwMCIgZW5hYmxlLWJhY2tncm91bmQ9Im5ldyAwIDAgODY5IDUwMCIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+DQo8cmVjdCBmaWxsPSIjRjFGMkYyIiB3aWR0aD0iODY5IiBoZWlnaHQ9IjUwMCIvPg0KPHRleHQgdHJhbnNmb3JtPSJtYXRyaXgoMSAwIDAgMSAyMjEuMjY4MyAyNjAuMzQ0NykiIGZpbGw9IiM2RDZFNzEiIGZvbnQtZmFtaWx5PSInT3BlblNhbnMtU2VtaWJvbGQnIiBmb250LXNpemU9IjM2Ij53ZWJjb21wIGltYWdlIG1pc3Npbmc8L3RleHQ+DQo8L3N2Zz4NCg=="
		end
	end

	def image(image)
		if user_signed_in?
			link_to image.url, :target => "_blank" do
				image_tag image.preview_url, title: 'Click for high resolution image'
			end
		else
			image_tag image.preview_url, title: 'Login for high resolution image'
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

	def tearsheet_url
		if model.images.where("image_type = 'TS'").first.present?
			model.images.where("image_type = 'TS'").first.url
		end
	end




end
