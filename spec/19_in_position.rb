require './spec_helper'

describe Robot do
  before :each do
    Robot.set_robot_instances=([])
    @robot = Robot.new
    @robot2 = Robot.new
    @robot3 = Robot.new
  end

  describe "Robot#in_position" do
    it "should give array of robots in position" do
      # pp Robot.robot_instances
      expect(Robot.in_position(0,0)).to match_array([@robot, @robot2, @robot3])
    end
  end
end