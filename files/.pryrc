Pry.config.editor = "vim"

bye_bug_commands = ['continue', 'step', 'next', 'finish']

if defined?(PryByebug)
  bye_bug_commands.each do |command|
    Pry.commands.alias_command command.first, command
  end
end

Pry::Commands.command /^$/, "repeat last command" do
  command = Pry.history.to_a.last
  if bye_bug_commands.concat(bye_bug_commands.map(&:first)).include?(command)
    _pry_.run_command command
  end
end
