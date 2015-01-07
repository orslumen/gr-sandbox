# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.test? || Rails.env.development?
  Consumer.seed!( { 'Consumer A1' => ['Arie', 'Annie'], 'Consumer B1' => ['Barrie', 'Bonnie'] } )
end