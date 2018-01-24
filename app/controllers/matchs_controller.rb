class MatchsController < ApplicationController
  def index
    @matchs = Match.paginate :page => params[:page], :per_page => 5
    @winner_teams = {}
    @matchs.each do |val|
      val.games
      teams = []
      val.games.each do |game|
        teams << game['winner_team_id']
      end
      most_win_team = teams.max_by { |i| teams.count(i) }
      @winner_teams[val['id']] = ''
      if teams.count(most_win_team) >= 2
        @winner_teams[val['id']] = Team.find(most_win_team)['name']
      end
    end
  end

  def show
	 @match = Match.find params[:id]
	 @games = @match.games.order(:created_at).paginate :page => params[:page], :per_page => 3
 #    @all_users = User.all
  end

  def new
  	@match = Match.new
	end
 
  def create
    @match = Match.new match_params
    if @match.save
	    flash[:notice] = "Match saved."
      redirect_to @match
	  else
	    render :new
	  end
  end

  def edit
    @match = Match.find params[:id]
  end
 
  def update
    @match = Match.find params[:id]
    if @match.update_attributes(match_params)
      flash[:notice] = "Match saved."
      redirect_to @match
    else
      render :edit
    end
  end
 
  def destroy
    @match = Match.find params[:id]
    @match.destroy
    flash[:notice] = "Match deleted."
    redirect_to matchs_path
  end

  private
  def match_params
    params.require(:match).permit(:title)
  end
end
