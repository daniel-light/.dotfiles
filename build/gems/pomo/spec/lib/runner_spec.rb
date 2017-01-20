require 'pomo'

describe Pomo::Runner do
  let(:timer) { double('timer') }
  let(:runner) { Pomo::Runner.new(timer) }

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
end
