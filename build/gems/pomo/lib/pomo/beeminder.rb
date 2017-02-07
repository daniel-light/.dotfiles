require 'beeminder'

module Pomo
  # Provides an interface to the beeminder gem for recording pomos.
  class BeeminderInterface
    attr_reader :bee

    def initialize(bee)
      @bee = bee
    end

    def record(time, topic)
      comment = "#{time.strftime('%H:%M')} #{topic}"

      bee.send('pomo', 1, comment)
      bee.send('morning-pomo', 1, comment) if time.hour < 12

      nil
    end

    def self.from_rc
      token = File.read("#{ENV['HOME']}/.beeminderrc").split(' ').last
      bee = Beeminder::User.new(token)
      new(bee)
    end
  end
end
