class Import

  def get_user(data)
    data["players"].find do |player|
      player["battletag"] == BATTLETAG
    end
  end

  def get_teammates(data, user)
    data["players"].select do |player|
      player["team"] == user["team"] && player["battletag"] != BATTLETAG
    end
  end

  def get_opponents(data, user)
    data["players"].select do |player|
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
      Hero.find_or_create_by(name: hero["name"]).update(role: hero["role"].upcase[0..3])
      # this_hero.role = hero["role"].upcase[0..3] if !this_hero.role
      # this_hero.save
    end
  end

  def upload_replays
    puts ""
    puts "Uploading replays...".cyan
    #TODO: allow configuring the directory in profile
    dir = "/Volumes/hots_replays"

    Dir.glob(dir + "/*.StormReplay") do |file|
      if !Match.find_by(original_path: file)
        data = RestClient.post 'http://hotsapi.net/api/v1/replays/', :file => File.new(file)
        data = JSON.parse(data.body)

        if data["status"] =="AiDetected"
          Match.find_or_create_by(original_path: file)
          puts ""
          puts "AI Detected   #{file}".green
        else
          match = Match.find_or_create_by(replay_id: data["id"])
          match.update(original_path: file)
          # match.original_path = file if !match.original_path
          # match.save

          puts ""
          puts match.replay_id.to_s.green
          # binding.pry if !match.replay_id
        end

        sleep(1.5)
      end
    end
  end

  def import_match_data
    puts ""
    puts "Importing data for uploaded matches...".cyan

    skipped = false

    Match.all.each do |match|
      if !match.game_date && match.replay_id

        data = RestClient.get "http://hotsapi.net/api/v1/replays/#{match.replay_id}"
        data = JSON.parse(data.body)

        if !data["processed"]
          if @skip_counter >= 10
            puts "Stop trying to import #{data["id"]}? (y/n)"
            match.update(replay_id: nil) if gets.strip == "y"
          else
            skipped = true
            puts "Waiting for #{data["id"]} to finish processing".red
          end

          next
        end

        puts "Importing #{data["id"]}".green

        user = get_user(data)

        map = Map.find_or_create_by(name: data["game_map"])
        map.matches << match

        match.hero_picks << user_pick = HeroPick.create(picked_by: "user")
        user_hero = Hero.find_or_create_by(name: user["hero"])
        user_hero.hero_picks << user_pick

        get_teammates(data, user).each do |teammate|
          match.hero_picks << teammate_pick = HeroPick.create(picked_by: "teammate")
          teammate_hero = Hero.find_or_create_by(name: teammate["hero"])
          teammate_hero.hero_picks << teammate_pick
        end

        get_opponents(data, user).each do |opponent|
          match.hero_picks << opponent_pick = HeroPick.create(picked_by: "opponent")
          opponent_hero = Hero.find_or_create_by(name: opponent["hero"])
          opponent_hero.hero_picks << opponent_pick
        end

        match.update(
          result: user_win?(user),
          game_type: data["game_type"],
          game_date: data["game_date"][0..9]
        )

        puts ""
        puts "#{match.replay_id}   #{match.game_date}".green

        sleep(1.5)

      else
      end
    end
    if skipped
      @skip_counter += 1

      sleep(5)
      import_match_data
    end
  end

  def initialize
    @skip_counter = 0
    import_maps
    import_heroes
    upload_replays
    import_match_data
  end

end
