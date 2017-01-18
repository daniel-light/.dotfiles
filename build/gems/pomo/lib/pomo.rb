require 'pomo/version'
require 'pomo/timer'

module Pomo
  # This class, when run, tracks a pomodoro alternating between a 32 minute work
  # period and an 8 minute break period. It outputs to standard out and a file
  class Runner
    SIG_ROTATE = 'SIGUSR1'.freeze

    def initialize
      @timer = Timer.new
      @pomo_file_name = '/tmp/pomo.timer'
      @sounds_dir = ENV['HOME']
    end

    def run
      trap_signals

      while sleep(1)
        if timer.period_complete?
          timer.switch_period
          play_sound(timer.period_type)
        end

        write_formatted_string
      end

      nil
    end

    private

    attr_accessor :timer, :pomo_file_name, :sounds_dir

    def trap_signals
      on_termination = proc do
        puts 'Removing pomo timer file'
        cleanup
        exit
      end

      Signal.trap('TERM', &on_termination)
      Signal.trap('INT', &on_termination)

      on_rotate = proc do
        puts "Changing period in response to #{SIG_ROTATE}"
        timer.switch_period
      end

      Signal.trap(SIG_ROTATE, &on_rotate)

      nil
    end

    def write_formatted_string
      File.open(pomo_file_name, 'w') do |file|
        time_string = "#{timer.formatted_clock} #{timer.period_type} 🍅"
        puts time_string
        file.write(time_string)
      end

      nil
    end

    def play_sound(period)
      file = "#{sounds_dir}/pomo_#{period}_start.mp3"
      Process.detach(fork { system("mpv #{file}") }) if File.exist?(file)

      nil
    end

    def cleanup
      File.delete(pomo_file_name) if File.exist?(pomo_file_name)

      nil
    end
  end
end
