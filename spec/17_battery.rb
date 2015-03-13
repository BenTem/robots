require './spec_helper'

describe Robot do
  before :each do
    @robot = Robot.new
  end

  let(:shield) { Battery.new }

  describe "#pick_up" do
    it "should automatically recharge battery" do
      @robot.shield = 0
      expect(shield).to receive(:recharge).and_call_original
      @robot.pick_up(shield)
      expect(@robot.shield).to eq(50)
    end
  end
end