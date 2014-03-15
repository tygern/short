require "data_mapper"
require "dm-mysql-adapter"

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'mysql://root:@localhost/short')

class UrlAdapter
  include DataMapper::Resource

  property :id,              Serial
  property :original_url,    String, :length => 255
  property :created_at,      DateTime
end

DataMapper.finalize