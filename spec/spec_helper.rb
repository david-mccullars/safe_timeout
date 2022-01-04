require 'English'
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'simplecov'

FileUtils.rm_rf('coverage') # Prevent old runs from merging in
SimpleCov.command_name(Process.pid.to_s)

SimpleCov.start do
  add_filter '/spec/'
end

require 'safe_timeout'
# Ensure all files get loaded (for coverage sake)
Dir[File.expand_path('../lib/**/*.rb', __dir__)].each do |f|
  require f[%r{lib/(.*)\.rb$}, 1]
end
