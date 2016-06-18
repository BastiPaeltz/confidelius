module Confidelius
  class Base < DatabaseUser
    include Singleton

    def init
      setup_tables
    end


    def list
      @db.execute('SELECT name from Session') do |row|
        puts row
      end
    end

    def setup_tables
      create_table_queries = [<<-SESSION, <<-OPERATION, <<-ENV, <<-FILE]
        CREATE TABLE IF NOT EXISTS Session(
          name TEXT PRIMARY KEY,
          active INTEGER
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
        create_table_queries.each { |query| @db.execute(query) }
        puts "Created database at #{ENV['_confidelius_db']}"
      rescue SQLite3::Exception => e
        puts 'Failed to create database. Reason:', "#{e.message}"
      end
    end

    private :setup_tables
  end
end