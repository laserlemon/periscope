require File.expand_path('../schema', __FILE__)

class User < ActiveRecord::Base
  scope :male, where(:gender => 'male')
  scope :female, where(:gender => 'female')
  scope :rich, where('salary >= ?', 1000000)

  def self.gender(gender)
    where(:gender => gender)
  end

  def self.makes(salary)
    where('salary >= ?', salary)
  end
end
