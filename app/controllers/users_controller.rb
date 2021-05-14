class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  # function UserList
  # return userlist
  def index
  	@users = UsersService.UserListAll(params[:page])
  end

  #function User Detail
  #param userid
  #return user
  def show
  	@user = UsersService.findUserById(params[:id])
  	respond_to do |format|
	   	format.html
	    format.js
	end
  end

  #function new
  #return new user
  def new
    @user = User.new
  end

  #function create user form
  #param user form params
  #reutrn create confirm form
  def create_form
    @user = User.new(user_params)
    # save profile image
    if user_params.has_key?(:profile)
      dir = "#{Rails.root}/app/assets/profiles/"
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      profilename = user_params[:name]+ "_" + Time.now.strftime('%Y%m%d_%H%M%S') + "." + ActiveStorage::Filename.new(user_params[:profile].original_filename).extension
      File.open(Rails.root.join('app/assets/', 'images', profilename ), 'wb') do |f|
          f.write(user_params[:profile].read)
      end
      @user.profile = profilename
    end

    unless @user.valid?
      render :new
    else
      redirect_to :action => "create_confirm", name: @user.name, email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation, role: @user.role, phone: @user.phone, dob: @user.dob, address: @user.address, profile: @user.profile
    end
  end

  #function create user confirm form
  #params user params
  #return create user
  def create_confirm
  	@name = params[:name]
    @email = params[:email]
    @password =params[:password]
    @password_confirmation = params[:password_confirmation]
    @role = params[:role]
    @dob = params[:dob]
    @phone = params[:phone]
    @address = params[:address]
    @profile = params[:profile]
    
    @user = User.new(name: @name, email: @email, password: @password, password_confirmation: @password_confirmation, role: @role, phone: @phone, dob: @dob, address: @address, profile: @profile)
  end

  #function create user
  #params user params
  #return create user
  def create
  	isSaveUser = UsersService.createUser(user_params,current_user)
    if isSaveUser
      	redirect_to users_path
    else
    	flash[:error] = "Error- please try to create an account again."
      render :new
    end
  end

  #function user profile
  #params user id
  #return user 
  def profile
  	@user = UsersService.findUserById(params[:id])
  end

  #function user edit
  #params user id
  #return user
  def edit_profile
  	@user = UsersService.findUserById(params[:id])
  	user = UsersService.findUserById(params[:id])
  	@user_profile_form = UserProfileForm.new(UserProfileForm.attributes(user, :edit_profile))
  end

  def update_profile
	@user_profile_form = UserProfileForm.new(user_profile_params)
	if user_profile_params[:edit_profile].present?
      dir = "#{Rails.root}/app/assets/profiles/"
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      profilename = user_profile_params[:name]+ "_" + Time.now.strftime('%Y%m%d_%H%M%S') + "." + ActiveStorage::Filename.new(user_profile_params[:edit_profile].original_filename).extension
      File.open(Rails.root.join('app/assets/', 'images', profilename ), 'wb') do |f|
          f.write(user_profile_params[:edit_profile].read)
  	end
	  	@user_profile_form.profile = profilename
	end
  	unless @user_profile_form.valid?
      render :edit_profile
    else
      redirect_to :action => "update_confirm", id: @user_profile_form.id, name: @user_profile_form.name, email: @user_profile_form.email, role: @user_profile_form.role, phone: @user_profile_form.phone, dob: @user_profile_form.dob, address: @user_profile_form.address, profile: @user_profile_form.profile
    end
  end


   def update_confirm
   	@id = params[:id]
  	@name = params[:name]
    @email = params[:email]
    @role = params[:role]
    @phone = params[:phone]
    @dob = params[:dob]
    @address = params[:address]
    @profile = params[:profile]
    
    @user = UserProfileForm.new(id: @id,name: @name, email: @email, role: @role, phone: @phone, dob: @dob, address: @address, profile: @profile)
  end

  def user_update
  	 saveupdateProfile = UsersService.updateProfile(user_profile_params)
  	 if saveupdateProfile 
  	 	redirect_to users_path
  	 else
  	 	render :edit_profile
  	 end
  end
  #function user destroy
  #params user id
  def destroy
  	UsersService.destroyUser(params[:id])
  	redirect_to users_path
  end

  #function search user
  #params search user form 
  #return search user
  def search_user
  	@users = UsersService.searchUser(params)
    render :index
  end

  private
  # User params
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :role, :phone, :dob, :address, :profile, :create_user_id, :updated_user_id)
  end

  def user_profile_params
  	params.require(:user_profile_form).permit(:id, :name, :email, :role, :phone, :dob, :address, :profile, :edit_profile)  	
  end
end
