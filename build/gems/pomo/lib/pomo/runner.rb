# frozen_string_literal: true

require 'shellwords'

module Pomo
  # This class, when run, tracks a pomodoro alternating between a 32 minute work
  # period and an 8 minute break period. It outputs to standard out and a file
  class Runner
    SIG_ROTATE = 'USR1'
    SIGNALS_TO_HANDLE = {
      'TERM' => :on_terminate,
      'INT' => :on_terminate,
      SIG_ROTATE => :on_rotate,
    }.freeze

    def initialize(timer, opts = {})
      @timer = timer
      @pomo_file_name = opts[:pomo_file_name] || '/tmp/pomo.timer'
      @sounds_dir = opts[:sounds_dir] || ENV['HOME']
    end

    def run
      trap_signals

      while sleep(1)
        switch_period if timer.period_complete?

        write_formatted_string
      end

      nil
    end

    def switch_period
      timer.switch_period
      play_sound(timer.period_type)
      ask_user_for_pomo_topic if timer.period_type == :break
    end

    def trap_signals
      SIGNALS_TO_HANDLE.each do |signal, handler_name|
        Signal.trap(signal) { __send__(handler_name) }
      end

      nil
    end

    def cleanup
      File.delete(pomo_file_name) if File.exist?(pomo_file_name)
      SIGNALS_TO_HANDLE.each { |signal, _| Signal.trap(signal, 'DEFAULT') }

      nil
    end

    def ask_user_for_pomo_topic
      Process.detach(fork do
        sleep(2)

        Timeout.timeout(30) do
          comment = prompt_user('pomo topic: ')
          beemind_and_notify(comment)
        end
      end)
    end

    def beemind_and_notify(comment)
      if comment.blank?
        notify('Empty comment, not sending pomo')
      elsif beemind(comment)
        notify('Recorded pomo with: ' + comment)
      else
        notify('Pomo sending failed')
      end
    end

    def prompt_user(prompt)
      `cat /dev/null | dmenu -p #{Shellwords.shellescape(prompt)}`.strip
    end

    def notify(message)
      Process.detach(fork { exec('notify-send', message) })
    end

    def beemind(comment)
      time = Time.now
      annotated_comment = time.strftime('%d-%H:%M') + ' ' + comment
      goal = time.hour < 12 ? 'pomo-morning' : 'pomo'
      system('beemind', goal, '1', annotated_comment)
    end

    private

    attr_accessor :timer, :pomo_file_name, :sounds_dir

    def on_terminate
      puts 'Removing pomo timer file'
      cleanup
      exit
    end

    def on_rotate
      puts "Changing period in response to #{SIG_ROTATE}"
      timer.switch_period
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
      Process.detach(fork { exec("mpv #{file}") }) if File.exist?(file)

      nil
    end
  end
end
