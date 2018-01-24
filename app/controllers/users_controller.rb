class UsersController < ApplicationController
  def index
    @users = User.paginate :page => params[:page], :per_page => 5
  end

  def show
		@user = User.find params[:id]
  end

  def new
  	@user = User.new
	end
 
	def create
	  @user = User.new user_params
	  if @user.save
	    flash[:notice] = "#{@user.first_name} saved."
	    redirect_to @user
	  else
	    render :new
	  end
	end

	def edit
    @user = User.find params[:id]
  end
 
  def update
    @user = User.find params[:id]
    if @user.update_attributes(user_params)
      flash[:notice] = "#{@user.first_name} saved."
      redirect_to @user
    else
      render :edit
    end
  end
 
  def destroy
    user = User.find params[:id]
    user.destroy
    flash[:notice] = "#{user.first_name} deleted."
    redirect_to users_path
  end

	private
  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
