require 'pomo/version'
require 'pomo/config'
require 'pomo/timer'
require 'pomo/runner'
require 'active_support/all'
# require 'pomo/beeminder'

# This gem implements a pomodoro timer.
module Pomo
  def self.run
    Runner.new(Timer.new).run
  end
end
