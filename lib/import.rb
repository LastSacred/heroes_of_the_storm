class Import

  def get_user(match)
    match["players"].find do |player|
      puts player["battletag"].blue
      player["battletag"] == BATTLETAG
    end
  end

  def get_teammates(match, user)
    match["players"].select do |player|
      player["team"] == user["team"] && player["battletag"] != BATTLETAG
    end
  end

  def get_opponents(match, user)
    match["players"].select do |player|
      player["team"] != user["team"]
    end
  end

  def user_win?(user)
    if user["winner"]
      1
    else
      0
    end
  end

  def import_maps
    puts ""
    puts "Searching for new maps...".cyan
    data = RestClient.get 'http://hotsapi.net/api/v1/maps'
    data = JSON.parse(data.body)

    data.each do |map|
      Map.find_or_create_by(name: map["name"])
    end
  end

  def import_heroes
    puts ""
    puts "Searching for new heroes...".cyan
    data = RestClient.get 'http://hotsapi.net/api/v1/heroes'
    data = JSON.parse(data.body)

    data.each do |hero|
      this_hero = Hero.find_or_create_by(name: hero["name"])
      this_hero.role = hero["role"].upcase[0..3] if !this_hero.role
      this_hero.save
    end
  end

  # def import_match_dates
  #   Match.all.each do |match|
  #     if !match.game_date
  #       id = match.replay_id
  #       data = RestClient.get "http://hotsapi.net/api/v1/replays/#{id}", {params: {min_id: (PROFILE.last_import + 1), with_players: true}}
  #       data = JSON.parse(data.body)
  #       match.game_date = data["game_date"][0..9]
  #       match.save
  #     end
  #     puts "#{match.replay_id}   #{match.game_date}".blue
  #     sleep(2)
  #   end
  # end

  def import_matches
    puts ""
    puts "Searching for new matches...".cyan
    loop do
      data = RestClient.get 'http://hotsapi.net/api/v1/replays/', {params: {min_id: (PROFILE.last_import + 1), with_players: true}}
      data = JSON.parse(data.body)
      puts "Waiting for more records...".cyan if data.size < 100

      data.each do |match|
        if match["region"] == REGION && match["game_type"] == "HeroLeague" && !Match.find_by(replay_id: match["id"]) && (user = get_user(match))
          puts "FOUND!!!!!!!!!!!!!!!!!!!!!!!!".green
          puts "#{match["game_type"]} - #{match["region"]} - #{match["id"]}".blue

          this_match = Match.create(
            replay_id: match["id"],
            result: user_win?(user),
            game_date: match["game_date"][0..9]
          )

          this_map = Map.find_or_create_by(name: match["game_map"])
          this_map.matches << this_match

          this_match.hero_picks << user_pick = HeroPick.create(picked_by: "user")
          user_hero = Hero.find_or_create_by(name: user["hero"])
          user_hero.hero_picks << user_pick

          get_teammates(match, user).each do |teammate|
            this_match.hero_picks << teammate_pick = HeroPick.create(picked_by: "teammate")
            teammate_hero = Hero.find_or_create_by(name: teammate["hero"])
            teammate_hero.hero_picks << teammate_pick
          end

          get_opponents(match, user).each do |opponent|
            this_match.hero_picks << opponent_pick = HeroPick.create(picked_by: "opponent")
            opponent_hero = Hero.find_or_create_by(name: opponent["hero"])
            opponent_hero.hero_picks << opponent_pick
          end

        end
        puts "#{match["game_type"]} - #{match["region"]} - #{match["id"]} - #{match["created_at"]}".blue
        puts ""
        puts ""
        PROFILE.last_import = match["id"]
        PROFILE.save
      end
      sleep(4)
    end
  end

  def initialize
    import_maps
    import_heroes
    #import_match_dates
    import_matches
  end

end
