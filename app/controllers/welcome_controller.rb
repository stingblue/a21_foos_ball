class WelcomeController < ApplicationController

  # GET /welcome
  def index
  	@matchs = Match.all
  	@count_matchs = @matchs.length
  	@all_teams = Team.all
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
        @winner_teams[val['id']] = most_win_team
      end
    end

    @ret = {}
    count = 0
    @all_teams.each do |team|
		number_win = @winner_teams.each_with_object(Hash.new(0)) {|(k,v),h| h[v]+=1 if v == team.id} 
    	@ret[team['name']] = number_win
    	count=count+1
    end
    # a{'match_1'} = team1
    # a{'match_2'} = team1
    # a{'match_3'} = team4
    @ret = @ret.sort_by {|k,v| v.values}.reverse
  end
end
