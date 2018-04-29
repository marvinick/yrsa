

require "shrine"
require "shrine/storage/s3"

s3_options = {
  access_key_id:     ENV.fetch("AWS_ACCESS_KEY_ID"),
  secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"),
  region:            ENV.fetch("AWS_REGION"),
  bucket:            ENV.fetch("AWS_BUCKET"),
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
  store: Shrine::Storage::S3.new(prefix: "store", **s3_options),
}
 
