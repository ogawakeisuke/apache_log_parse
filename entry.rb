require 'dm-core'
require 'dm-migrations'
DataMapper.setup(:default, 'sqlite3:db.sqlite3')

class Entry
  include DataMapper::Resource
  property :id, Serial
  property :ip_address, String
  property :user, String
  property :datetime, DateTime
  property :request, String
  property :status, String
  property :size, String
  property :referer, String
  property :user_agent, String
  auto_upgrade!
end