require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
  t.libs << %w(test lib)
end