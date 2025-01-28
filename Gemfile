source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.1"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 2.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Use the database-backed adapters for Rails.cache and Active Job
gem "solid_cache"
gem "solid_queue"

gem "httparty"
gem "nokogiri"
gem "view_component"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  gem "standard"
  gem "standard-rails"
end

gem "jsbundling-rails", "~> 1.3"

gem "cssbundling-rails", "~> 1.4"

gem "litestack", github: "oldmoe/litestack", branch: "master"

gem "dockerfile-rails", ">= 1.7", group: :development
