class SessionsController < ApplicationController	
	def new
	end

  	def create
    	@user = User.find_by(email: params[:user][:email])
    if !@user
      	message = "Email not Exits"
      	redirect_to login_path, notice: message
    elsif @user && @user.authenticate(params[:user][:password])
      	if params[:remember_me]
        	cookies.permanent[:user_id] = @user.id
      	else
        	cookies[:user_id] = { :value => @user.id, :expires => Time.now + 3600}
      	end
      		redirect_to root_path
    	else
      	message = "Incorrect Password!"
      	redirect_to login_path, notice: message
    	end
  	end

	def destroy
	  	cookies.delete(:user_id)
    	redirect_to login_path
	end

	def login
	    @user = User.new
	end

	private
  	# User params
  	def user_params
    	params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :role, :phone, :dob, :profile, :create_user_id, :updated_user_id)
  	end
end
