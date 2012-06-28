require File.expand_path('../connection', __FILE__)

ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :users, :force => true do |t|
    t.string :name
    t.string :gender
    t.integer :salary, :default => 0, :null => false
    t.timestamps
  end
end
