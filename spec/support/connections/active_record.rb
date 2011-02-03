require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :name
    t.string :gender
    t.integer :salary
  end
end

class User < ActiveRecord::Base
end
