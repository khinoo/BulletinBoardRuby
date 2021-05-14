class UserProfileForm
	include ActiveModel::Model
	include ActiveModel::Serialization

	attr_accessor :id, :name, :email, :role, :phone, :dob, :address, :profile, :edit_profile
	validates :id, :name, presence: true
	validates :email, presence: true, :format => { :with => URI::MailTo::EMAIL_REGEXP }

	def self.attributes(profile_params, edit_profile)
		{
			:id => profile_params.id,
			:name => profile_params.name,
			:email => profile_params.email,
			:role => profile_params.role,
			:phone => profile_params.phone,
			:dob => profile_params.dob,
			:address => profile_params.address,
			:profile => profile_params.profile,
			:edit_profile => edit_profile,
		}
	end
end