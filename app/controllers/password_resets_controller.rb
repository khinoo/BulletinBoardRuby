class PasswordResetsController < ApplicationController
  	def new
  	end

  	def create
	  user = User.find_by_email(params[:email])
	  user.send_password_reset if user
	  flash[:notice] = 'E-mail sent with password reset instructions.'
	  redirect_to login_path
	end

	def edit
	  @user = User.find_by_password_reset_token!(params[:id])
	end

	def update
	  	@user = User.find_by_password_reset_token!(params[:id])
	  	if @user.password_reset_sent_at < 2.hour.ago
	    	flash[:notice] = 'Password reset has expired'
	    	redirect_to new_password_reset_path
	    elsif params[:user][:password] != params[:user][:password_confirmation]
	      redirect_to edit_password_reset_path, :notice => "Passwords and Confirm Password must be same."
	    elsif @user.update_attribute(:password, params[:user][:password])
	      redirect_to login_path, :notice => "Password has been reset!"
	    else
	    	render :edit
	  	end
	end
end
