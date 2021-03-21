# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

carbohydrates = Measure.create!(name: 'carbohydrates', user_id: 1)
proteins = Measure.create!(name: 'proteins', user_id: 1)
fats = Measure.create!(name: 'fats', user_id: 1)