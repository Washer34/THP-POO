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

def welcome
  print "+"
  print "-" * 49
  puts "+"
  puts "|     Bienvenue sur 'ILS VEULENT TOUS MA POO'     |"
  puts "| Le but du jeu est d'être le dernier survivant ! |"
  print "+"
  print "-" * 49
  puts "+"
end

def display_game_over
  print "+"
  print "-" * 51
  puts "+"
  puts "|     \u2620  \u{1F635}  \u2620  OH NON ! TU AS PERDU ! \u2620  \u{1F635}  \u2620     |"
  print "+"
  print "-" * 51
  puts "+"
end

def display_victory
  print "+"
  print "-" * 51
  puts "+"
  puts "|   \u{2728} \u{1F389} \u{2728}   VICTOIRE, TU AS GAGNÉ ! \u{2728} \u{1F389} \u{2728}     |"
  print "+"
  print "-" * 51
  puts "+"
end

ennemies = []

welcome

dialogue("Qui es-tu, combattant ?")
print ">"
player = HumanPlayer.new(gets.chomp.to_s)
player1 = Player.new("Josiane")
ennemies << player1
player2 = Player.new("José")
ennemies << player2

while player.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
  puts ""
  player.show_state
  puts ""
  dialogue("Quelle action veux-tu effectuer ?")
  puts "a - Chercher une meilleure arme"
  puts "s - Chercher à se soigner"
  puts ""
  puts "Attaquer un joueur en vue:"
  print "0 - "
  print player1.show_state
  print "1 - "
  puts player2.show_state
  answer = gets.chomp
  system("clear")
  if answer == "a"
    player.search_weapon
  elsif answer == "s"
    player.search_health_pack
  elsif answer == "0"
    player.attacks(player1)
  elsif answer == "1"
    player.attacks(player2)
  end
  puts ""
  sleep(2)
  if player1.life_points <= 0 && player2.life_points <= 0
    break
  end
  dialogue("Les autres joueurs t'attaquent !")
  ennemies.each do |ennemy|
    if ennemy.life_points > 0
      ennemy.attacks(player)
    end
  end  
end

dialogue("La partie est finie.") # Ecran de fin
if player.life_points > 0
  display_victory
else
  display_game_over
end