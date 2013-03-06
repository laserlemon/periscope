require File.expand_path("../connection", __FILE__)

class User
  include DataMapper::Resource

  property :id, Serial
  property :gender, String
  property :salary, Integer

  def self.male
    all(gender: "male")
  end

  def self.female
    all(gender: "female")
  end

  def self.gender(gender)
    all(gender: gender)
  end

  def self.makes(salary)
    all(:salary.gte => salary)
  end
end

DataMapper.finalize
