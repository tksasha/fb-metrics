require_relative 'config/application'

task foo: :environment do
  puts Rails.root
  puts Rails.env
end

#
# need for `rake db:*`
#
task :environment do
  ActiveRecord::Base.establish_connection YAML.load_file('config/database.yml')[Rails.env]
end

#
# `rake db:*`
#
spec = Gem::Specification.find_by_name 'activerecord'
load "#{ spec.gem_dir }/lib/active_record/railties/databases.rake"
