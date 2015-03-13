require './spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  describe "#shield" do
    it "should be 100" do
      expect(@robot.shield).to eq(50)
    end

    it "should decrease before health" do
      enemy = Robot.new
      enemy.move_up
      enemy.attack(@robot)
      expect(@robot.shield).to eq(45)
    end

    it "health should decrease when shield is 0" do
      enemy = Robot.new
      enemy.move_up
      @robot.shield=0
      enemy.attack(@robot)
      expect(@robot.shield).to eq(0)
    end

    it "health should decrease when shield is 0" do
      @robot.shield=0
      @robot.wound(5)
      expect(@robot.health).to eq(95)
    end

    it "negative shield should lower health" do
      @robot.wound(80)
      expect(@robot.health).to eq(70)
    end




  end
end
