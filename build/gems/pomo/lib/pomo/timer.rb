module Pomo
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
      @pomo_file_name = '/tmp/pomo.timer'
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

    def switch_period
      self.period_type = (period_type == :work ? :break : :work)
      self.period_start = Time.now
      play_sound("#{ENV['HOME']}/#{period_type}_start.mp3")

      nil
    end

    def write_formatted_string
      File.open(pomo_file_name, 'w') do |file|
        time_string = "#{formatted_clock} #{period_type} 🍅"
        puts time_string
        file.write(time_string)
      end

      nil
    end

    def cleanup
      File.delete(pomo_file_name) if File.exist?(pomo_file_name)

      nil
    end

    def play_sound(filename)
      Process.detach(fork { system("mpv #{filename}") }) if File.exist?(filename)

      nil
    end
  end
end
