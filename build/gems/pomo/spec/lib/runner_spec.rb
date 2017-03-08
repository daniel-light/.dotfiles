require 'pomo'

describe Pomo::Runner do
  let(:timer) { double('timer', switch_period: nil) }
  let(:bee) { double('beeminder interface') }
  let(:runner) { Pomo::Runner.new(timer, bee: bee, sounds_dir: '') }

  before(:each) do
    # make sure signals are normal for each test
    Pomo::Runner::SIGNALS_TO_HANDLE.each do
      # |signal, _| Signal.trap(signal, 'DEFAULT')
    end
  end

  context '#run' do
    it 'calls #trap_signals' do
      allow(runner).to receive(:sleep).and_return(false)

      expect(runner).to receive(:trap_signals)
      runner.run
    end
  end

  context 'signal handling' do
    context '#trap_signals' do
      xit 'traps signals' do
        # I can test that we're calling Signal.trap
        # but I can't figure how to actually send the signal
        # without driving rspec totally insane
      end
    end
  end

  context 'beeminder interface' do
    it 'should ask the user for a pomo topic if the completed pre-switch period was work' do
      allow(timer).to receive(:period_complete?).and_return(true)
      allow(timer).to receive(:period_type).and_return(:work)

      expect(runner).to receive(:ask_user_for_pomo_topic)
      runner.switch_period
    end

    it 'should not ask if the completed period was a break' do
      allow(timer).to receive(:period_complete?).and_return(true)
      allow(timer).to receive(:period_type).and_return(:break)

      expect(runner).not_to receive(:ask_user_for_pomo_topic)
      runner.switch_period
    end

    it 'should not ask if the period was not complete' do
      allow(timer).to receive(:period_complete?).and_return(false)
      allow(timer).to receive(:period_type).and_return(:work)

      expect(runner).not_to receive(:ask_user_for_pomo_topic)
      runner.switch_period
    end
  end
end
