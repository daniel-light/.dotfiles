require 'pomo'

describe Pomo::Timer do
  # let(:Timer) { Pomo::Timer }
  let(:timer) { Pomo::Timer.new }

  context '#period_complete?' do
    it 'should not be complete when new' do
      expect(timer.period_complete?).to be false
    end

    it 'should be complete when the remaining time is 0' do
      allow(timer).to receive(:remaining_time).and_return(0)

      expect(timer.period_complete?).to be true
    end
  end

  context '#switch_period' do
    let(:current_time) { Time.now }

    it 'should switch to the other period type' do
      initial_period = timer.period_type

      timer.switch_period
      expect(timer.period_type).not_to eq initial_period

      timer.switch_period
      expect(timer.period_type).to eq initial_period
    end

    it 'should set the period start to the current time' do
      allow(Time).to receive(:now).and_return(current_time)
      timer.period_start += 500

      timer.switch_period

      expect(timer.period_start).to eq current_time
    end

    it 'should return nil' do
      expect(timer.switch_period).to be nil
    end
  end
end
