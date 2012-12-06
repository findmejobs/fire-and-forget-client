require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'yard'

YARD::Rake::YardocTask.new

RSpec::Core::RakeTask.new(:rspec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['-cfs --backtrace']
end

task :default => :rspec
