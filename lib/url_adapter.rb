require "data_mapper"
require "dm-postgres-adapter"

DataMapper.setup(:default, ENV['DATABASE_URL'])

class UrlAdapter
  include DataMapper::Resource

  property :id,              Serial
  property :original_url,    String, :length => 255
  property :created_at,      DateTime
end

DataMapper.finalize