require 'pry'
class Game
  attr_accessor :human_player, :enemies

  def dialogue(texte) # affichage du dialogue
    texte.chars.each do |char|
      print char
      sleep(0.02)
    end
    puts ""
  end

  def initialize(name)
    vilains = ["Dracula", "Zorglub", "Cruella", "Dark Vador", "Le Schtroumpf vénère","Docteur Gang", "Pouet-Pouet", "Le Général Bâillon", "Le Robot Ouvre-Boîte", "Le Professeur Chocottes", "L'Empereur des Biscuits", "Le Chef des Pompons Géants" ]
    @enemies = []
    @human_player = HumanPlayer.new(name)
    player1 = Player.new("#{vilains.delete(vilains.sample)}")
    player2 = Player.new("#{vilains.delete(vilains.sample)}")
    player3 = Player.new("#{vilains.delete(vilains.sample)}")
    player4 = Player.new("#{vilains.delete(vilains.sample)}")
    @enemies << player1 << player2 << player3 << player4
  end

  def kill_player(player)
    enemies.delete(player)
  end

  def is_still_going?
    if @human_player.life_points > 0 && @enemies.length > 0
      return true
    else 
      return false
    end
  end

  def show_players
    puts @human_player.show_state
    puts "#{enemies.length} ennemis restants"
  end

  def menu
    dialogue("Quelle action veux-tu effectuer ?")
    puts "a - Chercher une meilleure arme"
    puts "s - Chercher à se soigner"
    puts ""
    puts "Attaquer un joueur en vue:"
    enemies.each_with_index do |player, index|
      if player.life_points > 0
        puts "#{index} - #{player.show_state}"
      end
    end
  end

  def menu_choice(answer)
    if answer == "a"
      @human_player.search_weapon
    elsif answer == "s"
      @human_player.search_health_pack
    elsif answer.to_i.between?(0,enemies.length)
      @human_player.attacks(enemies[answer.to_i])
      if enemies[answer.to_i].life_points < 1
        kill_player(enemies[answer.to_i])
      end
    else 
      nil
    end
    sleep(2)
    puts ""
  end

  def enemies_attack
    puts"Les autres joueurs t'attaquent !"
    @enemies.each do |enemy|
      if enemy.life_points > 0
        enemy.attacks(@human_player)
      end
    end  
  end

  def game_over 
    if @human_player.life_points > 0
      print "+"
      print "-" * 51
      puts "+"
      puts "|   \u{2728} \u{1F389} \u{2728}   VICTOIRE, TU AS GAGNÉ ! \u{2728} \u{1F389} \u{2728}     |"
      print "+"
      print "-" * 51
      puts "+"
    else
      print "+"
      print "-" * 51
      puts "+"
      puts "|     \u2620  \u{1F635}  \u2620  OH NON ! TU AS PERDU ! \u2620  \u{1F635}  \u2620     |"
      print "+"
      print "-" * 51
      puts "+"
    end

  end

end
