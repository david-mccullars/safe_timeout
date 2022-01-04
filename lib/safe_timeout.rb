require 'timeout'

#
# Ruby's Timeout is broken and highly dangerous. To avoid this risk we instead
# use a child process to handle the timeout. We fork it and let it issue a SIGINT
# (Ctrl-C) to the parent if the timeout is reached.
#
module SafeTimeout

  autoload :InterruptingChildProcess, 'safe_timeout/interrupting_child_process'
  autoload :Spawner, 'safe_timeout/spawner'

  def self.timeout(sec, klass = nil, &block)
    Spawner.new(
      timeout:    sec,
      on_timeout: ->(_) { raise(klass || Timeout::Error) },
    ).start(&block)
  end

  def self.send_signal(signal, pid)
    Process.kill(signal, pid) if pid
  rescue Errno::ESRCH
    # do nothing
  end

end
