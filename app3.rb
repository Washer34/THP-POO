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

welcome

dialogue("Qui es-tu, combattant ?")
print ">"
my_game = Game.new(gets.chomp.to_s)

while my_game.is_still_going?
  my_game.menu
  answer = gets.chomp 
  system("clear")
  my_game.menu_choice(answer)
  if my_game.enemies.length == 0
    break
  end
  my_game.enemies_attack
  sleep(2)
  if my_game.human_player.life_points < 1
    break
  end
  my_game.show_players
  gets.chomp
  system("clear")
end
dialogue("La partie est finie.") # Ecran de fin
my_game.game_over
binding.pry