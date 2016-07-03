module Confidelius
  class HookAction < Action
    include Singleton

    def execute(optional_args)
      puts optional_args
      # TODO:
      # check all files that got touched by a 'FileAction' and create
      # a git pre-commit hook to check if confidential data gets checked
      # into source control
    end

  end
end