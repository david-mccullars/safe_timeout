module SafeTimeout
  class InterruptingChildProcess

    def initialize(expiration)
      @ppid = Process.ppid
      @expiration = expiration.to_f

      abort "Invalid pid to monitor: #{@ppid}" if @ppid.to_i.zero?
      abort "Invalid expiration: #{@expiration}" unless @expiration > 0.0
    end

    def notify_parent_of_expiration
      SafeTimeout.send_signal('TRAP', @ppid)
    end

    def wait_for_timeout
      Signal.trap('HUP') { exit 0 }

      sleep [@expiration - Time.now.to_f, 0.1].max

      notify_parent_of_expiration
    end

  end
end
