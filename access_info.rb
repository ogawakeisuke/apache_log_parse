require 'dm-core'
require 'dm-migrations'
DataMapper.setup(:default, 'sqlite3:db.sqlite3')

class AccessInfo
  include DataMapper::Resource
  property :id, Serial
  property :url, String
  property :pv, Integer
  property :uu, Integer
  property :date_at, DateTime
  auto_upgrade!
end