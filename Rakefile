require 'rake'
require 'rspec/core/rake_task'
require 'faker'
require_relative 'db/config'
require_relative 'lib/students_importer'
require_relative 'app/models/teacher'
require_relative 'app/models/student'


desc "create the database"
task "db:create" do
  touch 'db/ar-students.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/ar-students.sqlite3'
end

desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end

desc "populate the test database with sample data"
task "db:populate" do
  StudentsImporter.import
  9.times do 
    Teacher.new(:first_name => Faker::Name.first_name, :last_name => Faker::Name.last_name, :email => Faker::Internet.email, :phone => Faker::PhoneNumber.phone_number).save
  end
  # Student.all.each { |student| student.update_attributes(teacher_id: rand(9)+1)}
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "generate a new migration"
task "db:generate:migration", :name do |t, args|
  timestamp = Time.now.strftime('%Y%m%d%H%M%S')
  name = args[:name]
  # touch "#{timestamp}_#{name}.rb"a
  unless File.exists?("#{timestamp}_#{name}.rb")
    File.open("db/migrate/#{timestamp}_create_#{name}.rb", 'w') do |f|
      f.write("class Create#{name.capitalize} < ActiveRecord::Migration
  def change
    create_table :#{name} do |t|

      t.timestamps

    end
  end
end")
    end
  end
end

desc "Runs drop, create, migrate, and populate to set up db"
task "db:setup" do
  Rake::Task['db:drop'].execute
  puts "dropped"
  Rake::Task['db:create'].execute
  puts "created"
  Rake::Task['db:migrate'].execute
  puts "migrated"
  Rake::Task['db:populate'].execute
  puts "populated"
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

task :default  => :specs
