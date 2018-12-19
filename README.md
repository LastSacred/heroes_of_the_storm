---Intent-----

The purpose of this application is to take in one player's battle data from the game Heroes of the Storm, and use the information to analyze the player's win% as each heroes, with, and against each hero, and make draft recommendations based on this analysis.

Heroes of the Storm wiki: https://en.wikipedia.org/wiki/Heroes_of_the_Storm

---notes-----

While the initial intention of this program could be accomplished well enough with a 1 player to many heroes model, I am writing this as a many players to many heroes through battles model to allow for flexible functionality in the future.

---Explanation of terms-----

player: battles have many payers, 10 to be exactly, but the player for our purposes represents the player who's data is being analyzed.

hero_as: the hero the player played as this battle

heroes_with: the heroes played by the player's team mates

heroes_against: the heroes played by the player's opponents
