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
%{
server: rvm 2.4.1 do bin/rails server
assets: rvm 2.4.1 do bin/webpack-dev-server
}
end


insert_into_file 'app/controllers/application_controller.rb', before: 'end' do
%{
  prepend_view_path Rails.root.join("frontend")
}
end

remove_file 'app/views/layouts/application.html.erb'
file 'app/views/layouts/application.slim' do
%{
doctype html
html lang="cs"
  head
    = csrf_meta_tags
    = action_cable_meta_tag
    = javascript_pack_tag "application"
    = stylesheet_pack_tag "application"

  body
    = yield
end
}
end


run 'mv app/javascript frontend/'


file 'frontend/packs/application.js' do
%{
import "./application.css";

document.body.insertAdjacentHTML("afterbegin", "Webpacker works!");
}
end



file 'frontend/packs/application.scss' do
 """
  html, body {
    background: lightyellow;
    h1 { color: 'red' }
  }
"""
end


gsub_file 'config/webpacker.yml', /app\/javascript/, 'frontend'

