# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(email: "admin@test.com", password: "whatever", password_confirmation: "whatever")
User.create(email: "test@test.com", password: "whatever", password_confirmation: "whatever")
User.create(email: "test1@test.com", password: "whatever", password_confirmation: "whatever")
User.create(email: "test2@test.com", password: "whatever", password_confirmation: "whatever")
User.create(email: "test3@test.com", password: "whatever", password_confirmation: "whatever")
User.create(email: "test4@test.com", password: "whatever", password_confirmation: "whatever")
User.update_all confirmed_at: DateTime.now