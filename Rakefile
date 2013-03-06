require "bundler/gem_helper"
require "rspec/core/rake_task"

Bundler::GemHelper.install_tasks(name: "periscope")
Bundler::GemHelper.install_tasks(name: "periscope-activerecord")
Bundler::GemHelper.install_tasks(name: "periscope-mongo_mapper")
Bundler::GemHelper.install_tasks(name: "periscope-mongoid")
Bundler::GemHelper.install_tasks(name: "periscope-data_mapper")

ADAPTERS = %w(active_record data_mapper mongo_mapper mongoid)

ADAPTERS.each do |adapter|
  desc "Run RSpec code examples for #{adapter} adapter"
  RSpec::Core::RakeTask.new(adapter => "#{adapter}:adapter") do |t|
    t.pattern = "spec/periscope/adapters/#{adapter}_spec.rb"
  end

  namespace adapter do
    task :adapter do
      ENV["ADAPTER"] = adapter
    end
  end
end

RSpec::Core::RakeTask.new(spec: [:coverage] + ADAPTERS + [:adapter]) do |t|
  t.pattern = "spec/periscope_spec.rb"
end

task :coverage do
  ENV["COVERAGE"] = "true"
end

task :adapter do
  ENV["ADAPTER"] = nil
end

Rake::Task[:spec].enhance do
  require "simplecov"
  require "coveralls"

  Coveralls::SimpleCov::Formatter.new.format(SimpleCov.result)
end

task default: :spec
