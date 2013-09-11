require "dm-core"
require "dm-sqlite-adapter"

DataMapper.setup(:default, "sqlite::memory:")
