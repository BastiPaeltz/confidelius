module Confidelius
  class Session < DatabaseUser
    include Singleton

    # @param [Hash] required_args
    def start(required_args)
      if session_is_defined(required_args['session-name'])

      end
    end


    def stop(optional_args)
    end

    def save
    end

    def update_prompt(prompt, custom=false)
    end

    def session_is_defined(name)
    end

    private :session_is_defined

  end
end
