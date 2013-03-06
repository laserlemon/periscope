require File.expand_path("../schema", __FILE__)

class User < ActiveRecord::Base
  scope :male, proc { where(gender: "male") }
  scope :female, proc { where(gender: "female") }

  def self.gender(gender)
    where(gender: gender)
  end

  def self.makes(salary)
    where("salary >= ?", salary)
  end
end
