# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.destroy_all
CatRentalRequest.destroy_all
User.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!(:cats)
ActiveRecord::Base.connection.reset_pk_sequence!(:cat_rental_requests)
ActiveRecord::Base.connection.reset_pk_sequence!(:users)

users = []

10.times do
  users << User.create!(user_name: Faker::Name.name, password: Faker::Name.name)
end

sex = ["M", "F"]

cats = []
10.times do
  cats << Cat.create!(birth_date:  Faker::Date.birthday(1, 10), color: Cat::CAT_COLORS.sample, name: Faker::Cat.name, sex: sex.sample , description: "The best cat", user_id: users.sample.id)
end

CatRentalRequest.create!(cat_id: cats.first.id, start_date: Date.new(2017,7,14), end_date: Date.new(2017,7,21), user_id: 1)
CatRentalRequest.create!(cat_id: cats.first.id, start_date: Date.new(2017,7,22), end_date: Date.new(2017,7,29), user_id: 1)
CatRentalRequest.create!(cat_id: cats.first.id, start_date: Date.new(2017,6,12), end_date: Date.new(2017,8,1), user_id: 1)
CatRentalRequest.create!(cat_id: cats.first.id, start_date: Date.new(2017,7,16), end_date: Date.new(2017,7,18), user_id: 1)
CatRentalRequest.create!(cat_id: cats.first.id, start_date: Date.new(2017,7,16), end_date: Date.new(2017,7,23), user_id: 1)
CatRentalRequest.create!(cat_id: cats.first.id, start_date: Date.new(2017,7,10), end_date: Date.new(2017,7,18), user_id: 1)
