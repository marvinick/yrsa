json.extract! photo, :id, :image, :created_at, :updated_at
json.url photo_url(photo, format: :html)
json.image photo.image
