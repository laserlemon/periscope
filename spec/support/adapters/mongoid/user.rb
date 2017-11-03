require File.expand_path("../connection", __FILE__)

puts "USER"

class User
  include Mongoid::Document

  field :gender, type: String
  field :salary, type: Integer

  scope :male, proc { where(gender: "male") }
  scope :female, proc { where(gender: "female") }

  def self.gender(gender)
    where(gender: gender)
  end

  def self.makes(salary)
    where(:salary.gte => salary)
  end
end
