# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: "admin@gmail.com",
  password: "000000"
)

Tag.create([
  { name: 'メイン' },
  { name: 'スープ' },
  { name: 'サラダ' },
  { name: '丼・ワンプレート' },
  { name: 'プラスワン' },
  { name: 'おつまみ' },
  { name: 'デザート' }
])