class Coach
  attr_reader :user_picks, :user_heroes
  attr_accessor :map, :withheroes, :againstheroes, :bans

  #params - :map :withheroes :againstheroes :bans
  def initialize(params={})
    @user_picks = HeroPick.all.select { |pick| pick[:picked_by] == "user" }
    @user_heroes = @user_picks.collect { |pick| pick.hero }.uniq
    @map = params[:map]
    @withheroes = params[:withheroes]
    @againstheroes = params[:againstheroes]
    @bans = params[:bans]
  end

  def matches_as_hero(ashero)
    @user_picks.select { |pick| pick.hero == ashero }.collect do |pick|
      pick.match
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

    results.sum / results.count
  end

  def sort_and_print(list)
    list.sort_by { |name, score| score }.each do |name, score|
      puts score.to_s.blue + "   " + name.yellow
    end
  end

  def score_as_all_heroes
    results = Match.all.collect { |match| match.result * 1000 }
    mean(results)
  end

  def score_as_hero(ashero)
    matches = matches_as_hero(ashero)
    filler = 500

    get_score(matches, filler)
  end

  def rank
    list = {}

    @user_heroes.each do |ashero|
      list[ashero.name] = score_as_hero(ashero)
    end

    sort_and_print(list)
  end

  def score_including_hero_as_hero(otherhero, ashero, relationship)
    matches = matches_including_hero_as_hero(otherhero, ashero, relationship)
    filler = score_as_hero(ashero)
    get_score(matches, filler)
  end

  def rank_including_hero(otherhero, relationship)
    list = {}

    @user_heroes.each do |ashero|
      list[ashero.name] = score_including_hero_as_hero(otherhero, ashero, relationship)
    end

    sort_and_print(list)
  end

  def score_on_map_including_hero_as_hero(otherhero, ashero, relationship)
    matches = matches_on_map_including_hero_as_hero(otherhero, ashero, relationship)
    filler = score_including_hero_as_hero(otherhero, ashero, relationship)
    get_score(matches, filler)
  end

  def rank_on_map_including_hero(otherhero, relationship)
    list = {}

    @user_heroes.each do |ashero|
      list[ashero.name] = score_on_map_including_hero_as_hero(otherhero, ashero, relationship)
    end

    sort_and_print(list)
  end

  def score_on_map_as_hero(ashero)
    matches = matches_on_map_as_hero(ashero)
    filler = score_as_hero(ashero)
    get_score(matches, filler)
  end

  def rank_on_map
    list = {}

    @user_heroes.each do |ashero|
      list[ashero.name] = score_on_map_as_hero(ashero)
    end

    sort_and_print(list)
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

    results.sum / results.count
  end

  def rank_in_draft
    list = {}

    user_heroes.each do |ashero|
      if !(@withheroes + @againstheroes + @bans).include?(ashero)
        list[ashero.name] = score_in_draft_as_hero(ashero)
      end
    end

    sort_and_print(list)
  end

end
