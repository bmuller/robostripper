require "bundler/gem_tasks"
require 'rdoc/task'

RDoc::Task.new("doc") { |rdoc|
  rdoc.title = "Robostripper - Strip HTML websites like a Robot"
  rdoc.rdoc_dir = 'docs'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
}

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :default => :test
