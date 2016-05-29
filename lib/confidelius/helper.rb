module Confidelius
  class Helper
    def self.setup_db_env
      db_dir = 'res/'
      Dir.mkdir(db_dir) unless Dir.exist?(db_dir)
      ENV['_confidelius_db'] = File.expand_path('confidelius_db', db_dir)
    end
  end
end