class TeamsController < ApplicationController
  def index
    @teams = Team.paginate :page => params[:page], :per_page => 5
  end

  def show
	  @team = Team.find params[:id]
	  @users = @team.users.order(:created_at).paginate :page => params[:page], :per_page => 2
    @all_users = User.all
  end

  def new
  	@team = Team.new
	end
 
	def create
	  @team = Team.new team_params
	  if @team.save
	    flash[:notice] = "#{@team.name} saved."
	    redirect_to @team
	  else
	    render :new
	  end
	end

  def edit
    @team = Team.find params[:id]
  end
 
  def update
    @team = Team.find params[:id]
    if @team.update_attributes(team_params)
      flash[:notice] = "#{@team.name} saved."
      redirect_to @team
    else
      render :edit
    end
  end
 
  def destroy
    team = Team.find params[:id]
    team.destroy
    flash[:notice] = "#{team.name} deleted."
    redirect_to teams_path
  end

	private
  def team_params
    params.require(:team).permit(:name)
  end
end
