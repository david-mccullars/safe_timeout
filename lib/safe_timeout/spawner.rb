require 'English'
module SafeTimeout
  class Spawner

    def initialize(options = {})
      @expiration = Time.now.to_f + options.fetch(:timeout)
      @on_timeout = options.fetch(:on_timeout)
    end

    def start
      original = Signal.trap('TRAP', &@on_timeout) || 'DEFAULT'
      spawn_interrupter
      yield
    ensure
      Signal.trap('TRAP', original)
      stop
    end

    def stop
      # Tell that child to stop interrupting!
      SafeTimeout.send_signal('HUP', @child_pid)
    end

    def spawn_interrupter
      # Create a light-weight child process to notify this process if it is
      # taking too long
      bin = Gem.bin_path('safe_timeout', 'safe_timeout')
      @child_pid = Process.spawn(bin, $PROCESS_ID.to_s, @expiration.to_s)
      Process.detach(@child_pid)
    end

  end
end
