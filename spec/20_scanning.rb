require './spec_helper'

describe Robot do
  before :each do
    Robot.set_robot_instances= []
    @robot = Robot.new
    @robot2 = Robot.new
    @robot3 = Robot.new
    # @robot4 = Robot.new
    # @robot5 = Robot.new

    @robot.position=[0,0]
    @robot2.position=[0,1]
    @robot3.position=[1,0]
    # @robot4.position=[2,2]
    # @robot5.position=[3,3]
  end

    describe "#scan" do

      it 'should find robots in range' do
        # pp Robot.robot_instances
        expect(@robot.scan).to match_array([@robot2, @robot3])

      # it 'should find robots 1 and 2' do
      #   expect(@robot.scan.length).to eq(2) 
      end
    end
  end