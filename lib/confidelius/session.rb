module Confidelius
  class Session < DatabaseUser
    include Singleton

    # @param [Hash] required_args
    def start(required_args)
      session_name = required_args["<session-name>"]
      if session_is_defined(session_name)
        # TODO: jump into session, recreate state
        puts "session already defined"
      else
        create_session(session_name)
        puts "created session #{session_name}"
        # TODO: update command prompt so we know in which
        # session we're currently in
      end
    end


    def stop(optional_args)
      puts optional_args
      if optional_args.empty?
        ask_for_save
      elsif optional_args.has_key?("--save")
        save_changes_to_session
        end_session
      else
        # --no-save
        end_session
      end
    end

    def save
    end

    def update_prompt(prompt, custom=false)
    end

    def save_changes_to_session
      # TODO: save changes, refer to Confidelius::Session.save
      puts "saved"
    end

    def end_session
      # TODO: end the session without saving
      active_session = @db.execute( "SELECT name from Session WHERE active = 1")
      if active_session.empty?
        puts "No active sessions"
      end
      latest_active_session = active_session[0]
      # TODO: handle multiple active sessions (in different terminal windows)
      @db.execute( "UPDATE Session SET active = 0 WHERE name = ? ", latest_active_session)
      puts "Ended session #{latest_active_session}"
    end

    def ask_for_save
      puts "Do you want to save your current changes? (Y/n)"
      # TODO: show user what changed during his current session
      answer = STDIN.gets
      if answer.chomp! == 'n'
        end_session
      else
        save_changes_to_session
      end
    end

    def session_is_defined(name)
      result = @db.execute( "SELECT name from Session WHERE name = ?", name)
      result.empty? ? false : true
    end

    def create_session(name)
      @db.execute( "INSERT INTO Session VALUES (?, 1)", name)
    end

    private :session_is_defined, :create_session, :end_session,
    :save_changes_to_session, :ask_for_save

  end
end
