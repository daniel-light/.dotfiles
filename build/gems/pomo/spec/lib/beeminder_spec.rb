require 'pomo'

describe Pomo::BeeminderInterface do
  let(:bee) { double('beeminder user object') }
  let(:interface) { Pomo::BeeminderInterface.new(bee) }
  let(:morning_time) { Time.local(2017, 2, 6, 11, 59) }
  let(:afternoon_time) { Time.local(2017, 2, 6, 12, 0) }

  context '#record' do
    it 'sends to both in the morning' do
      expect(bee).to receive(:send).twice

      interface.record(morning_time, 'nothing, lol')
    end

    it 'only sends to pomo in the afternoon' do
      expect(bee).to receive(:send).once

      interface.record(afternoon_time, 'still nothing, eyyy')
    end
  end
end
