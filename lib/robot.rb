class Robot
  attr_accessor :position, :health, :items, :items_weight, :equipped_weapon, :shield

   @@robot_instances = []

  def initialize
    @position = [0,0] 
    @health = 100
    @items = []
    @items_weight = 0
    @equipped_weapon = nil
    @shield = 50

    @@robot_instances << self
  end

  def self.list_robots
    @@robot_instances
  end

  def self.set_robot_instances=(value)
    @@robot_instances = value
  end

  def self.robot_instances
    @@robot_instances
  end

  def self.in_position(position)
    @@robot_instances.select { |robot| robot.position == position}.first
  end

    def scan
    adjacent_spaces = [[self.position[0], self.position[1]+1], [self.position[0], self.position[1]-1], [self.position[1], self.position[0]+1], [self.position[1], self.position[0]-1]]

    adjacent_spaces.collect { |position| Robot.in_position(position) }.compact
  end

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end 

  def move_down
    @position[1] -= 1
  end

  def items
    @items
  end

  def pick_up(item)
    item.recharge(self) if item.is_a?(Battery)
    item.feed(self) if item.is_a?(BoxOfBolts) && self.health < 81
    return false if item.weight + @items_weight > 250
    @items.push(item) && @items_weight += item.weight
    @equipped_weapon = item if item.is_a? Weapon
    true
  end

  def wound(num)
    @shield -= num 
    if @shield < 0
      @health -= @shield.abs
      @shield = 0
    end

    @health = 0 if @health <= 0
  end

  def heal(num)
    @health += num
    if @health >= 100
      @health = 100
    end
  end

  def heal!(num)
      raise RobotAlreadyDeadError, "You are dead!" if @health <= 0
      @health += num
      @health = 100 if @health >= 100
  end



  def in_range_x?(enemy)
    (enemy.position[0] == self.position[0]+1 || enemy.position[0] == self.position[0]-1) && (enemy.position[1] == self.position[1])
  end

  def in_range_y?(enemy)
    (enemy.position[1] == self.position[1]+1 || enemy.position[1] == self.position[1]-1) && (enemy.position[0] == self.position[0])
  end

  def in_grenade_range_x?(enemy)
    (enemy.position[0] == self.position[0]+2 || enemy.position[0] == self.position[0]-2) && (enemy.position[1] == self.position[1])
  end

  def in_grenade_range_y?(enemy)
    (enemy.position[1] == self.position[1]+2 || enemy.position[1] == self.position[1]-2) && (enemy.position[0] == self.position[0])
  end

  def attack(enemy)

    if @equipped_weapon.is_a?(Grenade)
      @equipped_weapon.hit(enemy) if self.in_range_x?(enemy) || self.in_range_y?(enemy) || self.in_grenade_range_x?(enemy) || self.in_grenade_range_y?(enemy)
      @equipped_weapon = nil
    end

    if  self.in_range_x?(enemy) || self.in_range_y?(enemy)
      if @equipped_weapon 
        @equipped_weapon.hit(enemy)
      else
        enemy.wound(5)
      end
    end
  end

  def attack!(enemy)
        raise UnattackableEnemy, "You can't attack an item!" unless enemy.is_a? Robot
      if @equipped_weapon
        @equipped_weapon.hit(enemy)
      else
        enemy.wound(5)
      end

  end


end

class RobotAlreadyDeadError < StandardError
end

class UnattackableEnemy < StandardError
end
