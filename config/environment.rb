require 'bundler'
require 'csv'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/user.db')

require_all 'lib'

PROFILE = Profile.find(1)
BATTLETAG = PROFILE.battletag
REGION = PROFILE.region
# 13884213
