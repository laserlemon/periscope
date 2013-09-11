require File.expand_path("../user", __FILE__)

require "dm-migrations"

User.auto_migrate!
