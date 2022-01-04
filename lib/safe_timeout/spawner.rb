require 'English'
module SafeTimeout
  class Spawner

    def initialize(options = {})
      @expiration = Time.now.to_f + options.fetch(:timeout)
      @on_timeout = lambda do |*args|
        @timed_out = true
        options.fetch(:on_timeout).call(*args)
      end
      @timed_out = false
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
      SafeTimeout.send_signal('HUP', @child_pid) unless @timed_out
      Process.wait(@child_pid) rescue nil
    end

    def spawn_interrupter
      # Create a light-weight child process to notify this process if it is
      # taking too long
      bin = Gem.bin_path('safe_timeout', 'safe_timeout')
      @child_pid = Process.spawn({ 'COVERAGE' => defined?(SimpleCov) }, bin, @expiration.to_s)
      Process.detach(@child_pid)
    end

  end
end
