require 'rake/testtask'
require 'metric_fu'

Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = false
end

task :default => :test

namespace :test do

  desc 'Measures test coverage'
  task :coverage do
    rm_f "coverage"
    rm_f "coverage.data"
    rcov = "rcov --aggregate coverage.data --text-summary -Ilib:test"
    system("#{rcov} test/**/*.rb")
  end

end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.version
    gem.name            = "undata"
    gem.summary         = %Q{undata - UN Data client library}
    gem.description     = %Q{The UN have a number of initiatives to make data readily accessible. This library is intended to help in consuming and using that data.}
    gem.homepage        = "http://github.com/grahambrooks/undata"
    gem.email           = [ "graham@grahambrooks.com" ]
    gem.authors         = [ "Graham Brooks"]
    gem.add_development_dependency "mocha", ">= 0"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
