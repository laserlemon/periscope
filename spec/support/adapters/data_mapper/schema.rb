require "dm-migrations"

require File.expand_path("../user", __FILE__)

User.auto_migrate!
