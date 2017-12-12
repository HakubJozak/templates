# gem 'bootstrap-sass'
# gem 'font-awesome-rails'
gem 'slim-rails'
gem 'dotenv-rails'
gem 'simple_form'
gem "cells-rails"
gem "cells-slim"

gem_group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
end

after_bundle do
  %w( bootstrap font-awesome ).each do |package|
    run "yarn add #{package}"
  end

  generate :controller, "home index"
  route "root to: 'home#index'"
  # rails_command("db:migrate")

  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit' }
end
