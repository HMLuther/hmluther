json.array!(@items) do |item|
  json.extract! item, :id, :active, :description, :description_short, :sold, :location, :reference, :height, :width, :depth, :diameter
  json.url item_url(item, format: :json)
end
