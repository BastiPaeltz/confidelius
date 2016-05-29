module Confidelius
  class Base
    @@db

    def self.init
      @@db = SQLite3::Database.new(ENV['_confidelius_db'])
      setup_tables
    end


    def self.list
    end

    def self.setup_tables
      create_table_queries = [<<-SESSION, <<-OPERATION, <<-ENV, <<-FILE]
        CREATE TABLE IF NOT EXISTS Session(
          name TEXT PRIMARY KEY
        )
      SESSION
        CREATE TABLE IF NOT EXISTS Operation(
          id INT PRIMARY KEY,
          session_name TEXT,
          timestamp INT,
          FOREIGN KEY(session_name) REFERENCES Session(name)
        )
      OPERATION
        CREATE TABLE IF NOT EXISTS Env(
          operation_id INT,
          state_before TEXT,
          state_after TEXT,
          FOREIGN KEY(operation_id) REFERENCES Operation(id)
        )
      ENV
        CREATE TABLE IF NOT EXISTS File(
          operation_id INT,
          location TEXT,
          pattern TEXT,
          state_before TEXT,
          state_after TEXT,
          FOREIGN KEY(operation_id) REFERENCES Operation(id)
        )
      FILE
      begin
        create_table_queries.each { |query| @@db.execute(query) }
        p "Created database at #{ENV['_confidelius_db']}"
      rescue SQLite3::Exception => e
        p "Failed to create database. Reason #{e.message}"
      end
    end

    private_class_method :setup_tables
  end
end