require 'bcrypt'
class User < ActiveRecord::Base
 include BCrypt
 attr_accessible :encrypted_password, :role_id, :username
 belongs_to :role

def password
  @password ||=Password.new(encrypted_password)
end

def password=(value)
  @password=Password.create(value)
  self.encrypted_password=@password
end
end    
