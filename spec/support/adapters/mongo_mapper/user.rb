require File.expand_path("../connection", __FILE__)

class User
  include MongoMapper::Document

  key :gender, String
  key :salary, Integer

  scope :male, proc { where(gender: "male") }
  scope :female, proc { where(gender: "female") }

  def self.gender(gender)
    where(gender: gender)
  end

  def self.makes(salary)
    where(:salary.gte => salary)
  end
end
