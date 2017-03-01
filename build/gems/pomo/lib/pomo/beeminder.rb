require 'beeminder'

module Pomo
  # Provides an interface to the beeminder gem for recording pomos.
  class BeeminderInterface
    attr_reader :bee

    def initialize(bee)
      @bee = bee
    end

    def record(time, comment)
      Pomo::Config.beeminder_hooks.each do |hook|
        data = datapoint_hash_for(time, comment)

        if hook[:filter].call(data)
          goal = bee.goal(hook[:goal])
          dp = Beeminder::Datapoint.new(data)
          goal.add(dp)
        end
      end
    end

    def datapoint_hash_for(time, comment)
      {
        timestamp: time,
        comment: comment,
        value: value,
      }
    end

    def self.from_rc
      token = File.read("#{ENV['HOME']}/.beeminderrc").split(' ').last
      bee = Beeminder::User.new(token)
      new(bee)
    end
  end
end
