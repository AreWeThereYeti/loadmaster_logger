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

User.new({ 
  :username => 'admin', 
  :email => 'admin@loadmaster.dk',
  :password => 'loadmaster',
  :password_confirmation => 'loadmaster',
  :role_id => Role.find_by(:name => :Admin).id
}).save

hauler_user = User.new({ 
  :username => 'hauler', 
  :email => 'hauler@loadmaster.dk', 
  :password => 'loadmaster',
  :password_confirmation => 'loadmaster',
  :role_id => Role.find_by(:name => :Hauler).id
})

hauler_user.save

Trip.new({ 
  :license_plate => 'GX 234 543',
  :cargo => 'Sand',
  :chauffeur => 'Mikkel',
  :start_address => '',
  :start_location => [55.630225,12.049255],
  :end_address => '',
  :end_location => [55.754506,12.495575],
  :start_timestamp => "2013-09-09T16:00:00Z",
  :end_timestamp => "2013-09-09T18:00:00Z",
  :distance => '7',
  :weight => '600',
  :costumer => 'Bilka',
  :start_comments => 'Bilka skal have mange flere sten',
  :user_id => hauler_user.id
}).save

Trip.new({ 
  :license_plate => 'GX 234 543',
  :cargo => 'Grus',
  :chauffeur => 'Andreas',
  :start_address => 'Holtegade 11 3.tv 2200 København N',
  :start_location => [55.630225,12.049255],
  :end_address => 'Lærkevej 1, 3450 Allerød',
  :end_location => [55.754506,12.495575],
  :start_timestamp => "2013-09-10T16:00:00Z",
  :end_timestamp => "2013-09-10T18:00:00Z",
  :distance => '24',
  :weight => '1000',
  :costumer => 'Wasa',
  :start_comments => 'Wasa skal have meget grus i deres knækbrød',
  :user_id => hauler_user.id
}).save




# 
# Trip.new({ 
#   :license_plate => 'GX 234 543',
#   :cargo => 'Sand',
#   :chauffeur => 'Mikkel',
#   :start_address => 'null',
#   :start_location => [55.630225,12.049255],
#   :end_address => 'null',
#   :end_location => [55.754506,12.495575],
#   :start_timestamp => "2013-09-09T16:00:00Z",
#   :end_timestamp => "2013-09-09T18:00:00Z",
#   :distance => '7',
#   :weight => '600',
#   :costumer => 'Bilka',
#   :start_comments => 'Bilka skal have mange flere sten',
#   :user_id =>"565dd255616e648527010000"
# }).save