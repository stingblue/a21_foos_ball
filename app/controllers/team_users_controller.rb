class TeamUsersController < ApplicationController
  def create
    @team = Team.find params[:team_id]
    #user id get from select box
    user_id = params[:user][:id]
    
    if @team.users.length >= 2
      flash[:notice] = 'Team only 1 to 2 player'
      return redirect_to team_path(@team)
    end

    if @team.users.where(:id => user_id).exists?
      flash[:notice] = 'User exists'
      return redirect_to team_path(@team)
    end

    user = User.find(user_id)
    @team.users << user

    flash[:notice] = 'User added'
    redirect_to team_path(@team)
  end

  private
  def team_user_params
    params.require(:user).permit(:id)
  end
end
