require "bundler/gem_tasks"
require 'rdoc/task'

RDoc::Task.new("doc") { |rdoc|
  rdoc.title = "Robostripper - Strip HTML websites like a Robot"
  rdoc.rdoc_dir = 'docs'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
}

task :test do
  puts `ruby test/robostripper_test.rb`
end

task :default => 'test'
