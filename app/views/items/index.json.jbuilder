json.array!(@items) do |item|
  json.extract! item, :id, :filemaker_id, :active, :description, :description_short, :sold, :location, :reference, :height, :width, :depth, :diameter, 
 	:listed_category, :listed_designer,
  :created_at, :updated_at
  json.url item_url(item, format: :json)
end
