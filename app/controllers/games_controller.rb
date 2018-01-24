class GamesController < ApplicationController
  def index
    @games = Game.paginate :page => params[:page], :per_page => 5
    @game_teams = {}
    @game_matchs = {}
    @games.each do |value|
    	teams = []
    	teams << Team.find(value['team1_id'])['name']
    	teams << Team.find(value['team2_id'])['name']
    	teams << Team.find(value['winner_team_id'])['name']
    	@game_teams[value['id']] = teams
      mtch = []
      mtch << Match.find(value['match_id'])['title']
      @game_matchs[value['id']] = mtch
    end
  end

  def show
	  @game = Game.find params[:id]
	  @teams = []
  	@teams << Team.find(@game['team1_id'])['name']
	  @teams << Team.find(@game['team2_id'])['name']
	  @teams << Team.find(@game['winner_team_id'])['name']
	  @match = Match.find(@game['match_id']) 
  end

  def new
  	@game = Game.new
  	@all_teams = Team.all
  	@all_matchs = Match.all
  end
 
  def create
  	@game = Game.new game_params
  	if !check_valid(params)
  	  flash[:notice] = "Error: Invalid value!"
	   return redirect_to @game
  	end

	  if @game.save
	    flash[:notice] = "#{@game.id} saved."
	    redirect_to @game
	  else
	    render :new
	  end
  end

  def edit
    @game = Game.find params[:id]
    @all_teams = Team.all
    @all_matchs = Match.all
  end
 
  def update
    @game = Game.find params[:id]
    if !check_valid(params)
  	  flash[:notice] = "Error: Invalid value!"
	  return redirect_to @game
  	end

    if @game.update_attributes(game_params)
      flash[:notice] = "#{@game.id} saved."
      redirect_to @game
    else
      render :edit
    end
  end
 
  def destroy
    game = Game.find params[:id]
    game.destroy
    flash[:notice] = "#{game.id} deleted."
    redirect_to games_path
  end

  private
  def check_valid(params)
  	team1_id = params[:game][:team1_id]
  	team2_id = params[:game][:team2_id]
  	score = params[:game][:score]
  	match_id = params[:game][:match_id]
    winner_team_id = params[:game][:winner_team_id]
    mtch = Match.find(match_id)
    count_game = mtch.games.length
  	if count_game >= 3 || !match_id.present? || !score.present? || score.to_i < 0 || score.to_i > 10
  	  return false
  	end

  	if team1_id == team2_id || (winner_team_id != team1_id && winner_team_id != team2_id)
  	  return false
  	end

  	true
  end

  def game_params
    params.require(:game).permit(:team1_id, :team2_id, :score, :winner_team_id, :match_id)
  end
end
