require_relative "../config/environment.rb"

map = Map.find_by(name: "Braxis Holdout")

arta = Hero.find_by(name: "Artanis")
zaga = Hero.find_by(name: "Zagara")
genj = Hero.find_by(name: "Genji")
mura = Hero.find_by(name: "Muradin")

ltmo = Hero.find_by(name: "Lt. Morales")
sony = Hero.find_by(name: "Sonya")
zary = Hero.find_by(name: "Zarya")
limi = Hero.find_by(name: "Li-Ming")
xul = Hero.find_by(name: "Xul")

malg = Hero.find_by(name: "Mal'Ganis")
meph = Hero.find_by(name: "Mephisto")
azmo = Hero.find_by(name: "Azmodan")
diab = Hero.find_by(name: "Diablo")
orph = Hero.find_by(name: "Orphea")
kael = Hero.find_by(name: "Kael'thas")

withheroes = [arta, zaga]
againstheroes = [ltmo, sony]
bans = [malg, meph, azmo, diab]
coach = Coach.new(
  map: map,
  withheroes: withheroes,
  againstheroes: againstheroes,
  bans: bans
)

ashero = lili = Hero.find_by(name: "Li Li")
otherhero = withheroes[0]
relationship = "teammate"

binding.pry
0
