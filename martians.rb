# Very rough implementation Evil Martians fronend tutorial:
#
# https://evilmartians.com/chronicles/evil-front-part-1
#


# Usage:
#
# rails  new acant  -m ./templates/modern.rb --skip-coffee --skip-sprockets --skip-turbolinks --webpack --database=postgresql  -B
#

# Apply on existing project
#
# bin/rails app:template LOCATION=../templates/modern.rb
#

gem 'slim-rails'
gem 'dotenv-rails'
gem 'simple_form'
gem "cells-rails"
gem "cells-slim"

gem_group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
end

application """
  config.generators do |g|
    g.test_framework  false
    g.stylesheets     false
    g.javascripts     false
    g.helper          false
    g.channel         assets: false
  end
"""

file '.browserslistrc' do
  "> 1%\n"
end


rails_command 'active_storage:install'
generate 'simple_form:install --bootstrap'
remove_dir 'app/assets'


file 'Procfile' do
  """
  server: bin/rails server
  assets: bin/webpack-dev-server
  """
end

run 'mv app/javascript frontend/'
