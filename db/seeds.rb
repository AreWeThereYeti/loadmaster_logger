# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.new({ 
  :name => 'Admin'
}).save

Role.new({ 
  :name => 'Hauler'
}).save

Role.new({ 
  :name => 'MobileDevice'
}).save

User.new({ 
  :email => 'admin@loadmaster.dk', 
  :password => 'loadmaster',
  :password_confirmation => 'loadmaster',
  :role_ids => [Role.find_by(:name => :Admin).id]
}).save

User.new({ 
  :email => 'hauler@loadmaster.dk', 
  :password => 'loadmaster',
  :password_confirmation => 'loadmaster',
  :role_ids => [Role.find_by(:name => :Hauler).id]
}).save

User.new({ 
  :email => 'mobile@loadmaster.dk', 
  :password => 'loadmaster',
  :password_confirmation => 'loadmaster',
  :role_ids => [Role.find_by(:name => :MobileDevice).id]
}).save