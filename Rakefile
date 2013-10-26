require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << 'test'
end

task :default => :test

task :build => :clean do
  system 'gem', 'build', 'dns.gemspec'
end

task :push, [:gem] => :build do |t, args|
  args.with_defaults gem: Dir['*.gem'].first
  system 'gem', 'push', args.gem
end

task :install => :build do
  system 'gem', 'install', Dir['*.gem'].first
end

task :clean do
  Dir['*.gem'].each { |f| File.delete f }
end
