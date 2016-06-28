source "https://rubygems.org"

ruby "2.3.0", engine: "jruby", engine_version: "9.1.2.0"

gem "sinatra"
gem "sinatra-contrib"

group :production do
  gem 'trinidad'
end

group :development, :test do
  gem "puma"
  gem "rspec"
  gem "pry"
end
