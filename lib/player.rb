class Player
  attr_accessor :name, :life_points #readable and writable variables

  
  def dialogue(texte) # affichage du dialogue
    texte.chars.each do |char|
      print char
      sleep(0.02)
    end
    puts ""
  end

  def initialize(name) # I set up the name and life points of players
    @name = name
    @life_points = 10
  end

  def show_state # Shows the amount of HP
    "#{self.name} a #{self.life_points} points de vie"
  end

  def gets_damage(dmg) # Deals the amount of dmg and tells if someone has been killed
    self.life_points = (self.life_points - dmg)
    if self.life_points <= 0 
      dialogue("#{self.name} a été tué!")
    end
  end

  def attacks(target) # self player deals damages to target
    hit = compute_damage
    puts"#{self.name} attaque #{target.name} et lui inflige #{hit} dégats !"
    target.gets_damage(hit)
    sleep(0.05)
    puts ""
  end
  
  def compute_damage
    return rand(1..6)
  end

end

class HumanPlayer < Player
  attr_accessor :weapon_level, :name, :life_points

  def initialize(name)
    @name = name
    @life_points = 1
    @weapon_level = 1
  end

  def show_state # Shows the amount of HP
    puts "#{self.name} a #{self.life_points} points de vie et une arme de niveau #{self.weapon_level}"
  end

  def compute_damage
    rand(1..6) * self.weapon_level
  end

  def search_weapon
    dice = rand(1..6)
    dialogue("Tu as trouvé une arme de niveau #{dice} !")
    if dice <= self.weapon_level
      puts "Tu préfères garder ton arme actuelle."
    else
      puts "Elle est mieux que la tienne, tu l'équipes direct."
      self.weapon_level = dice
    end
  end

  def search_health_pack
    dice = rand(1..6)
    if dice == 1
      puts "Tu n'as rien trouvé..."
    elsif dice > 1 && dice <= 5
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
      self.life_points = self.life_points + 50
      if self.life_points > 100
        self.life_points = 100
      end
      puts "Tu as désormais #{self.life_points} points de vie"
    else
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
      self.life_points = self.life_points + 80
      if self.life_points > 100 
        self.life_points = 100
      end
      puts "Tu as désormais #{self.life_points} points de vie"
    end
  end

      
end