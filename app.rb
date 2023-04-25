require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def dialogue(texte) # affichage du dialogue
  texte.chars.each do |char|
    print char
    sleep(0.02)
  end
  puts ""
end
player1 = Player.new("Josiane")
player2 = Player.new("José")
system("clear") # Je clear le système
dialogue("A ma gauche voici le joueur numéro 1, tout droit venu du Texas : #{player1.name} !!")
sleep(2)
dialogue("A ma droite voici le joueur numéro 2, le fameux enfant élevé par des loups j'ai nommé : #{player2.name} !!")
puts ""
sleep(2)
system("clear") # Je clear le système
while player1.life_points > 0 && player2.life_points > 0
  dialogue("Voici l'état de nos joueur : ")
  dialogue("#{player1.show_state}")
  dialogue("#{player2.show_state}")
  sleep(2)
  dialogue("Passons à la phase d'attaque :")
  puts ""
  player1.attacks(player2)
  sleep(1)
  if player2.life_points <= 0
    break
  end
  player2.attacks(player1)
  sleep(1)
  puts ""
end
binding.pry