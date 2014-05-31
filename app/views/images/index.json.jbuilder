json.array!(@images) do |image|
  json.extract! image, :id, :active, :banner, :webcomp, :thumb, :image_type, :url
  json.url image_url(image, format: :json)
end
