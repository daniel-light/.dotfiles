module Pomo
  # This class holds the logic for the actual timer.
  class Timer
    attr_accessor :period_type, :period_start
    attr_reader :pomo_file_name

    PERIOD_LENGTH = {
      work: 60 * 32, # seconds
      break: 60 * 8, # seconds
    }.freeze

    def initialize
      self.period_type = :work
      self.period_start = Time.now
    end

    def period_length
      PERIOD_LENGTH[period_type]
    end

    def elapsed_time
      Time.now - period_start
    end

    def remaining_time
      PERIOD_LENGTH[period_type] - elapsed_time
    end

    def formatted_clock
      Time.at(remaining_time).strftime('%M:%S')
    end

    def period_complete?
      remaining_time <= 0
    end

    def switch_period
      self.period_type = (period_type == :work ? :break : :work)
      self.period_start = Time.now

      nil
    end
  end
end
