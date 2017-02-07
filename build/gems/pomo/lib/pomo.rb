require 'pomo/version'
require 'pomo/timer'
require 'pomo/runner'
require 'pomo/beeminder'

# This gem implements a pomodoro timer.
module Pomo
  def self.run
    Runner.new(Timer.new).run
  end
end
