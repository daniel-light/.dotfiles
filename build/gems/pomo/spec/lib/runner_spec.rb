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
    before(:each) do
      runner.trap_signals
    end

    context '#trap_signals' do
      xit 'traps SIGTERM' do
        expect(runner).to receive(:on_terminate)

        Process.kill 'TERM', 0
      end

      xit 'traps SIGUSR1' do
        # expect(runner).to receive(:on_rotate)
        expect(timer).to receive(:switch_period)

        Process.kill 'USR1', 0
      end
    end
  end
end
