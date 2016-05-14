DOC = <<MANPAGE
Confidelius.

Usage:
  confidelius new
  confidelius start [-s <session-name>] [-p <prompt>]
  confidelius stop [--save|--no-save] 
  confidelius list
  confidelius save 
  confidelius hook [--soft]
  confidelius env <environment-variable>
  confidelius file <regex-pattern> [-i] [--times <amount>] [--lines <start-line> <stop-line>]
  confidelius -h | --help
  confidelius --version

Options:
  -h --help     Show this screen.
  -s            Name your session explicitly, when you start one.
  -p            Specify a custom prompt (PS1), when starting a session.
  --save        stopping a session asks if changes should be saved.
                Specify this flag, when this should be done without asking. 
  --no-save     Opposite of --save
  --soft        By default, hook aborts a git commit when it finds violations,
                use this flag, when it should only print a warning.
  -i            Interactive mode, let the user choose for every match, if this should
                be replaced or not
  --times       Specify, how many times exactly a match should be replaced
  --lines       Specify, between which lines matches should be replaced      


MANPAGE

module Confidelius
  class CLI
    def self.parse
      begin
        puts Docopt::docopt(DOC)
      rescue Docopt::Exit => e
        puts e.message
      end
    end
  end
end
