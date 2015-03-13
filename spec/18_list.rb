require './spec_helper'

describe Robot do
  before :each do
    Robot.robot_instances([])
    @robot = Robot.new
    @robot2 = Robot.new
    @robot3 = Robot.new
  end

  describe "Robot#list_robots" do
    it "should list robots in array" do
      expect(Robot.list_robots.length).to eq(3)
    end
  end
end