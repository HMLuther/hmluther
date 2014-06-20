json.array!(@collection_items) do |collection_item|
  json.extract! collection_item, :id, :position
  json.url collection_item_url(collection_item, format: :json)
end
