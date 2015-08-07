Pry.config.editor = "vim"

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

Pry::Commands.command /^$/, "repeat last command" do
  command = Pry.history.to_a.last
  if ['continue', 'step', 'next', 'finish'].include?(command)
    _pry_.run_command command
  end
end
