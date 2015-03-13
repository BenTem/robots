class Battery < Item
  def initialize
    @name = 'Battery'
    @weight = 25
  end

  def recharge(robot)
    robot.shield = 50
  end

end