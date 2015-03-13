require './spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe "#heal!" do
    it "should raise error if dead" do
      @robot.wound(500)
      
      expect { @robot.heal!(10) }.to raise_error( RobotAlreadyDeadError, "You are dead!")
    end
  end

  describe '#attack!' do
    it "should raise error if enemy is not a robot" do
      bolty = BoxOfBolts.new
      expect { @robot.attack!(bolty) }.to raise_error( UnattackableEnemy, "You can't attack an item!")
    end
  end
end