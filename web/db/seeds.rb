# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Config.create!(key: 'current_semester', value: 'A18')
Config.create!(key: 'store_open_date', value: '2018-09-10')
Config.create!(key: 'store_close_date', value: '2018-10-10')
Config.create!(key: 'custom_patch_price', value: '4')

Config.create!(key: 'patch_plain_odd_background_color', value: '#2055aa')
Config.create!(key: 'patch_plain_odd_border_color', value: '#dee1e5')
Config.create!(key: 'patch_plain_odd_text_color', value: '#dee1e5')

Config.create!(key: 'patch_plain_even_background_color', value: '#dee1e5')
Config.create!(key: 'patch_plain_even_border_color', value: '#0952b7')
Config.create!(key: 'patch_plain_even_text_color', value: '#0952b7')


PatchType.create!(name: 'plain' )
PatchType.create!(name: 'founder')
PatchType.create!(name: 'degree')
