require 'spec_helper'

describe SafeTimeout do
  context '.timeout' do

    it 'should process its block' do
      result = nil
      expect do
        result = SafeTimeout.timeout(5) { :success }
      end.to_not raise_error
      expect(result).to eq(:success)
    end

    it 'should timeout if block takes too long' do
      result = nil
      expect do
        result = SafeTimeout.timeout(0.4) { sleep 3 and :failure }
      end.to raise_error(Timeout::Error)
      expect(result).to be_nil
    end

    it 'should not leave orphaned child process' do
      child = fork do
        SafeTimeout.timeout(5) { sleep 5 }
      end
      :loop until grand_child = all_processes[child].first
      expect(grand_child).to be > child

      Process.kill('TERM', child)
      expect(is_process_still_running? grand_child).to be false
    end

    private

    # Returns a hash of all running processes and their children
    def all_processes
      `ps -eo pid,ppid`.lines.reduce(Hash.new []) do |hash, line|
        pid, ppid = line.split.map(&:to_i)
        hash[ppid] = [] unless hash.key?(ppid)
        hash[ppid] << pid
        hash
      end
    end

    # Wait for up to 1 second for process to quit and report on
    # whether it did or not.
    def is_process_still_running?(pid)
      10.times do
        sleep 0.1
        begin
          Process.kill(0, pid)
        rescue Errno::ESRCH
          return false
        end
      end
      true
    end

  end
end
