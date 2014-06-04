require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Run specs'
RSpec::Core::RakeTask.new(:spec)

desc 'Default: run specs.'
task :default => :spec


desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r nfg-client.rb"
end
