json.array!(@collections) do |collection|
  json.extract! collection, :id, :active, :name, :description, :public
  json.url collection_url(collection, format: :json)
end
