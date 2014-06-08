json.array!(@designers) do |designer|
  json.extract! designer, :id, :name, :bio, :active, :include, :omit, :production_date, :website, :filemaker_id
  json.url designer_url(designer, format: :json)
end
