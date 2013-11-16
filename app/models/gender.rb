class Gender < ActiveRecord::Base
  attr_accessible :name
  has_one :student
end
