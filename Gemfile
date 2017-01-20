source "https://rubygems.org"
ruby "2.3.0"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# script dependencies
gem "httparty"
gem "twilio-ruby"

# rails defaults
gem "rails", "~> 5.0.1"
gem "pg"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :development, :test do
  gem "dotenv"
  gem "pry"
end

group :test do
  gem "rspec"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
