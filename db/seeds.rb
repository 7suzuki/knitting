# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "データの作成を開始します"

AdminUser.find_or_create_by!(email: ENV["ADMIN_USER_EMAIL"]) do |admin_user|
  admin_user.password = ENV["ADMIN_USER_PASSWORD"]
end

taro = User.find_or_create_by!(email: "taro@example.com") do |user|
  user.password = "aiueoka"
  user.name = "taro"
end

hanako = User.find_or_create_by!(email: "hanako@example.com") do |user|
  user.password = "aiueoka"
  user.name = "hanako"
end

Post.find_or_create_by!(body: "aiueo", user: taro)

puts "作成してあるデータ数: AdminUser: #{AdminUser.count}"

puts "データの作成が完了しました"
