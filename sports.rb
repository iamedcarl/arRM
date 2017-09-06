require_relative 'lib/night_mapper'

class Player < NightMapper
  belongs_to :team
  has_one_through :city, :team, :city

  finalize!
end

class Team < NightMapper
  belongs_to :city
  has_many :players

  finalize!
end

class City < NightMapper
  has_many :teams

  finalize!
end
