module Confidelius
  class FileAction < Action
    include Singleton

    def execute(required_args, optional_args)
      puts required_args
      puts optional_args
      # TODO:
      # 1. silent read user input
      # 2. save this to file based on regex pattern (all matches)
      # 3. save nput to db
    end

  end
end