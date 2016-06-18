module Confidelius
  class DatabaseUser
    def initialize
      @db = SQLite3::Database.new(ENV['_confidelius_db'])
    end
  end
end