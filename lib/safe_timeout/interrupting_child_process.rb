module SafeTimeout
  class InterruptingChildProcess

    def initialize(timeout:, on_timeout:)
      @expiration = Time.now.to_f + timeout
      @on_timeout = on_timeout
    end

    def start(&block)
      Signal.trap("TRAP", &@on_timeout)
      Kernel.fork { wait_for_expiration }
      yield
    ensure
      stop rescue nil
    end

    def stop
      # Tell that child to stop interrupting!
      Process.kill("HUP", @child_pid)
    end

    def wait_for_expiration
      Signal.trap("HUP") { exit 0 }

      # If the parent dies unexpectedly and the child is never told to
      # stop, it becomes an orphan and is given to the init process (1)
      # or worse yet it becomes a zombie with parent 0. In either case,
      # stop interrupting!
      while Process.ppid > 1
        sleep 0.1
        if Time.now.to_f > @expiration
          Process.kill("TRAP", Process.ppid)
          return
        end
      end
    end

  end

end
