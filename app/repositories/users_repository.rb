class UsersRepository
	class << self
		def UserListAll(page)
			@users = User.where(deleted_at: nil).paginate(:page => page, :per_page => 10)
		end

        def newUser
            @user = User.new
        end

        def createUser(user,current_user)
            @user = User.new(user)
            @user.role = @user.role == "Admin" ? 0 : 1
            @user.create_user_id = current_user.id
            @user.updated_user_id = current_user.id
            @user.created_at = Time.now
            saveUser = @user.save
        end

        def findUserById(id)
            @user = User.find(id)
        end

        def destroyUser(user)
            user.update_attribute(:deleted_at, Time.now)
        end

        def searchuser(name, email, created_from, created_to,page)
            if created_from.present? and created_to.present?
              users = User.where(deleted_at: nil).where("name like ? and email like ? and created_at >= ? and created_at <= ?", "%" + name + "%", "%" + email + "%", created_from, Date.parse(created_to)+1).paginate(:page => page, :per_page => 10)
            elsif created_from.present?
              users = User.where(deleted_at: nil).where("name like ? and email like ? and created_at >= ?", "%" + name + "%", "%" + email + "%", created_from).paginate(:page => page, :per_page => 10)
            elsif created_to.present?
              users = User.where(deleted_at: nil).where("name like ? and email like ? and created_at <= ?", "%" + name + "%", "%" + email + "%", Date.parse(created_to)+1).paginate(:page => page, :per_page => 10)
            else
              users = User.where(deleted_at: nil).where("name like ? and email like ?", "%" + name + "%", "%" + email + "%").paginate(:page => page, :per_page => 10)
            end
        end

        def updateUser(user,user_profile_param)
            updateProfile = user.update(
                'name' => user_profile_param[:name],
                'email'=> user_profile_param[:email],
                'role' => user_profile_param[:role],
                'phone'=> user_profile_param[:phone],
                'dob'  => user_profile_param[:dob],
                'address'=> user_profile_param[:address],
                'profile'=> user_profile_param[:profile]
            )
        end

        def updatePassword(user,password,current_user)
            isUpdatePassword = user.update(
              'password' => password,
              'updated_user_id' => current_user.id,
              'updated_at' => Time.now
            )
        end
	end
end