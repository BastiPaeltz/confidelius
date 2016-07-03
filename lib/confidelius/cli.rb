module Confidelius
  class CLI
    DOC = <<-MANPAGE
    Deals with confidential data.

    Usage:
      confidelius init
      confidelius start <session-name>
      confidelius stop [--save|--no-save]
      confidelius list
      confidelius status
      confidelius save
      confidelius hook [--soft]
      confidelius env <environment-variable>
      confidelius file <regex-pattern> [-i] [--times=<amount>] [--lines=<start-line>-<stop-line>]
      confidelius -h | --help
      confidelius --version

    Options:
      -h --help     Show this screen.
      -p            Specify a custom prompt (PS1), when starting a session.
      --save        stopping a session asks if changes should be saved.
                    Specify this flag, when this should be done without asking.
      --no-save     Opposite of --save
      --soft        By default, hook aborts a git commit when it finds
                    violations, use this flag to only print a warning.
      -i            Interactive mode, let the user choose for every match,
                    if this should be replaced or not
      --times=<amount>                  Specify, how many times exactly a match
                                        should be replaced
      --lines=<start-line>-<stop-line>  Specify, between which lines matches
                                        should be replaced

    MANPAGE

    def self.parse
      begin
        command_line_opts = Docopt::docopt(DOC)
        self.filter_relevant_opts(command_line_opts) do |action, required, optional|
          self.run_action(action, required, optional)
        end
      rescue Docopt::Exit => e
        puts e.message
      end
    end

    private

    def self.run_action(requested_action, required_args, optional_args)
      case requested_action
        when 'init' then
          Confidelius::Base.instance.init
        when 'start' then
          Confidelius::Session.instance.start(required_args)
        when 'stop' then
          Confidelius::Session.instance.stop(optional_args)
        when 'save' then
          Confidelius::Session.instance.save
        when 'status' then
          Confidelius::Session.instance.status
        when 'list' then
          Confidelius::Base.instance.list
        when 'hook' then
          Confidelius::HookAction.instance.execute(optional_args)
        when 'env' then
          Confidelius::EnvironmentAction.instance.execute(required_args)
        when 'file' then
          Confidelius::FileAction.instance.execute(required_args, optional_args)
      end
    end

    def self.filter_relevant_opts(command_line_opts)
      action = ''
      required_args = {}
      optional_args = {}

      filtered_opts = command_line_opts.reject do |_, val|
        val.nil? or val == false
      end

      filtered_opts.each do |key, val|
        if key.start_with?('<')
          required_args[key] = val
        elsif key.start_with?('-')
          optional_args[key] = val
        else
          action = key
        end
      end
      yield action, required_args, optional_args
    end
  end
end
