# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

categories = Category.create([
	{ name: 'Furniture', position: '1' },
	{ name: 'Lighting', position: '2' },
	{ name: 'Mirrors', position: '3' },
	{ name: 'Objects', position: '4' },
	{ name: 'Art', position: '5' }
	])

subcategories = Subcategory.create([
	{ name: 'Chairs', position: '1', category_id: '1' },
	{ name: 'Sofas, Beds, Daybeds', position: '2', category_id: '1' },
	{ name: 'Stools, Benches', position: '3', category_id: '1' },
	{ name: 'Bookcases, Vitrines', position: '4', category_id: '1' },
	{ name: 'Cabinets', position: '5', category_id: '1' },
	{ name: 'Commodes, Chests of Drawers', position: '6', category_id: '1' },
	{ name: 'Coffee, Cocktail Tables', position: '7', category_id: '1' },
	{ name: 'Console Tables', position: '8', category_id: '1' },
	{ name: 'Desks, Secretaries', position: '9', category_id: '1' },
	{ name: 'Etegeres, Shelves', position: '10', category_id: '1' },
	{ name: 'Table Tops', position: '11', category_id: '1' },
	{ name: 'Tables', position: '12', category_id: '1' },

	{ name: 'Candelabras, Candlesticks', position: '1', category_id: '2' },
	{ name: 'Chandeliers', position: '2', category_id: '2' },
	{ name: 'Lamps', position: '3', category_id: '2' },
	{ name: 'Sconces, Wall Lights', position: '4', category_id: '2' },
	{ name: 'Lanterns', position: '5', category_id: '2' },

	{ name: 'Boxes', position: '1', category_id: '4' },
	{ name: 'Clocks', position: '2', category_id: '4' },
	{ name: 'Jardinieres', position: '3', category_id: '4' },
	{ name: 'Objects', position: '4', category_id: '4' },
	{ name: 'Pedestals', position: '5', category_id: '4' },
	{ name: 'Screens', position: '6', category_id: '4' },
	{ name: 'Trays', position: '7', category_id: '4' },
	{ name: 'Vases, Bowls', position: '8', category_id: '4' },

	{ name: 'Pictures', position: '1', category_id: '5' },
	{ name: 'Sculptures', position: '2', category_id: '5' },

	])
