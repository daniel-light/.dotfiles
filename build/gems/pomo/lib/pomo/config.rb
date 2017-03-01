module Pomo
  # Provides a DSL for configuring beeminder goals in ~/.pomorc
  class Config
    @beeminder_hooks = []

    class << self
      attr_reader :beeminder_hooks

      def beemind(goal, &filter)
        @beeminder_hooks << {goal: goal, filter: filter}
      end
    end

    RC_FILE = "#{ENV['HOME']}/.pomorc"

    File.foreach(RC_FILE).each_with_index do |line, n|
      eval(line, binding, RC_FILE, n)
    end
  end
end
