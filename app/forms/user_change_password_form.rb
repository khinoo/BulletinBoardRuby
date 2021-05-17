class UserChangePasswordForm
  include ActiveModel::Model
  include ActiveModel::Serialization
  
  attr_accessor :id, :current_password, :new_password, :confirm_password
  validates_presence_of :current_password, :new_password, :confirm_password
  validates_confirmation_of :new_password
  validate :verify_current_password

  def verify_current_password
      user = UsersService.findUserById(id)
       if user.authenticate(current_password) == false
        errors.add(:current_password, "is incorrect.")
      end
  end
end