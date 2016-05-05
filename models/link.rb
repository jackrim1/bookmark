require 'data_mapper'
require 'dm-postgres-adapter'

class Link
	include DataMapper::Resource
	property :id, 		Serial
	property :title,	String
	property :url, 		String
end

# DataMapper.setup(:default, ENV['postgres://yheajcnpvtoorm:tj5GTaoW3bnPDNRTWHcx2aAu_I@ec2-107-20-174-127.compute-1.amazonaws.com:5432/dedmsmtp0a1ma7'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
