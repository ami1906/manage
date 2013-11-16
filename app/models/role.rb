class Role < ActiveRecord::Base
  attr_accessible :description, :name
  has_one :user
  Admin=1
  Faculty=2
end
