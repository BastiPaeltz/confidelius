module Confidelius
  class Base < DatabaseUser
    include Singleton

    def init
      setup_tables
      # TODO: encrypt db
    end

    def status
      # TODO: show current state
      # is session active or not?
      # how many changes were made (and not saved yet) ?
    end


    def list
      puts "Currently defined sessions:"
      puts "name\tactive"
      puts "----\t------"
      puts
      @db.execute('SELECT name, active from Session') do |row|
        if row[1] == 1
          puts "#{row[0]}\tyes"
        else
          puts "#{row[0]}\tno"
        end
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
