json.array!(@items) do |item|
  json.extract! item, :id, :filemaker_id, :active, :description, :description_short, :sold, :location, :reference, :height_cm, :width_cm, :depth_cm, :diameter_cm, :height_in, :width_in, :depth_in, :diameter_in, :size,
 	:listed_category, :listed_designer,
  :created_at, :updated_at
  json.url item_url(item, format: :json)
end
