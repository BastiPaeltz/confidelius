module Confidelius
  class EnvironmentAction < Action
    include Singleton

    def execute(optional_args)
      puts optional_args
      # TODO:
      # 1. silent read user input
      # 2. save user input to "selected" env var
      # 3. save user input to db
    end

  end
end