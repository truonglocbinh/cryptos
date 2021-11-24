# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


CryptoCurrency.create([
  {name: 'Bitcoin', short_name: 'BTC', multiisg_factor: 2},
  {name: 'Ethereum', short_name: 'ETH', multiisg_factor: 20},
  {name: 'Binance Smart Chain', short_name: 'BNB', multiisg_factor: 20},
  {name: 'Bitcoin SV', short_name: 'BSV'}
])