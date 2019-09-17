json.array!(@items) do |item|
  json.extract! item, :id, :filemaker_id, :active,
                :description, :description_short, :sold,
                :price_cents, :price_currency, :location, :reference,
                :height_cm, :width_cm, :depth_cm,
                :diameter_cm, :height_in, :width_in,
                :depth_in, :diameter_in, :size,
                :listed_category, :listed_designer,
                :designer_connector_1, :designer_connector_2,
                :created_at, :updated_at
  json.url item_url(item, format: :json)
end
