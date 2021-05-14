class User < ApplicationRecord

  has_secure_password

   def welcome
    "Hello, #{self.email}!"
  end

  def self.usertypes
    types = {
      '0' => 'Admin',
      '1' => 'User'
    }
  end
end
