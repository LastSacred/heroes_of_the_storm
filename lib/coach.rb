class Coach
  attr_reader :recent_matches, :user_heroes
  attr_accessor :map, :withheroes, :againstheroes, :bans, :otherhero

  def initialize(params={})
    #TODO: allow game type and number of days to be changed
    @recent_matches = Match.all.select { |match| match.replay_id && match.game_type == "HeroLeague" && match.game_date && match.game_date >= (Date.today - 90).strftime("%Y-%m-%d") }
    if PROFILE.list_type == "auto"
      @user_heroes = @recent_matches.collect { |match| match.hero_picks.find { |pick| pick.picked_by == "user" }.hero }.uniq
    else
      @user_heroes = Hero.all.select { |hero| hero.on_list == 1}
    end
    @map = params[:map]
    @withheroes = params[:withheroes]
    @againstheroes = params[:againstheroes]
    @bans = params[:bans]
    @otherhero = params[:otherhero]
  end

  def matches_as_hero(ashero)
    @recent_matches.select do |match|
      match.hero_picks.find { |pick| pick.picked_by == "user" && pick.hero == ashero }
    end
  end

  def matches_on_map_as_hero(ashero)
    matches_as_hero(ashero).select do |match|
      match.map == @map
    end
  end

  def matches_including_hero_as_hero(otherhero, ashero, relationship)
    matches_as_hero(ashero).select do |match|
      match.hero_picks.find do |pick|
        pick.picked_by == relationship && pick.hero == otherhero
      end
    end
  end

  def matches_on_map_including_hero_as_hero(otherhero, ashero, relationship)
    matches_including_hero_as_hero(otherhero, ashero, relationship).select do |match|
      match.map == @map
    end
  end

  def get_score(matches, filler)
    results = matches.collect { |match| match.result * 1000 }

    while results.count < 10 do
      results << filler
    end

    mean(results)
  end

  def score_as_all_heroes
    results = @recent_matches.collect { |match| match.result * 1000 }
    mean(results)
  end

  def score_as_hero(ashero)
    matches = matches_as_hero(ashero)
    filler = score_as_all_heroes

    get_score(matches, filler)
  end

  def rank
    list = {}

    @user_heroes.each do |ashero|
      list[ashero] = score_as_hero(ashero)
    end

    Printer.rank_list(list)
  end

  def score_including_hero_as_hero(otherhero, ashero, relationship)
    matches = matches_including_hero_as_hero(otherhero, ashero, relationship)
    filler = score_as_hero(ashero)
    get_score(matches, filler)
  end

  def rank_including_hero(otherhero=@otherhero, relationship)
    list = {}

    @user_heroes.each do |ashero|
      list[ashero] = score_including_hero_as_hero(otherhero, ashero, relationship)
    end

    Printer.rank_list(list)
  end

  def score_on_map_including_hero_as_hero(otherhero, ashero, relationship)
    matches = matches_on_map_including_hero_as_hero(otherhero, ashero, relationship)
    filler = score_including_hero_as_hero(otherhero, ashero, relationship)
    get_score(matches, filler)
  end

  def rank_on_map_including_hero(otherhero=@otherhero, relationship)
    list = {}

    @user_heroes.each do |ashero|
      list[ashero] = score_on_map_including_hero_as_hero(otherhero, ashero, relationship)
    end

    Printer.rank_list(list)
  end

  def score_on_map_as_hero(ashero)
    matches = matches_on_map_as_hero(ashero)
    filler = score_as_hero(ashero)
    get_score(matches, filler)
  end

  def rank_on_map
    list = {}

    @user_heroes.each do |ashero|
      list[ashero] = score_on_map_as_hero(ashero)
    end

    Printer.rank_list(list)
  end

  def score_in_draft_as_hero(ashero)
    results = []

    @withheroes.each do |otherhero|
      results << score_including_hero_as_hero(otherhero, ashero, "teammate")
    end

    @againstheroes.each do |otherhero|
      results << score_including_hero_as_hero(otherhero, ashero, "opponent")
    end

    while results.count < 10 do
      results << score_on_map_as_hero(ashero)
    end

    mean(results)
  end

  def rank_in_draft
    list = {}

    user_heroes.each do |ashero|
      if !(@withheroes + @againstheroes + @bans).include?(ashero)
        list[ashero] = score_in_draft_as_hero(ashero)
      end
    end

    Printer.rank_list(list)
  end

end
