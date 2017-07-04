#
# need for `rake db:*`
#
task :environment do
  ActiveRecord::Base.establish_connection YAML.load_file('config/database.yml')[Rails.env]

  Dir[Rails.root.join('app/*/*.rb')].each { |f| require f }
end

#
# `rake db:*`
#
load "#{ Gem::Specification.find_by_name('activerecord').gem_dir }/lib/active_record/railties/databases.rake"

#
# `rake spec`
#
load "#{ Gem::Specification.find_by_name('rspec-rails').gem_dir }/lib/rspec/rails/tasks/rspec.rake"
