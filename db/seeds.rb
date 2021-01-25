# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
r1 = Role.create({ name: 'Guest', description: 'Can read' })
r2 = Role.create({ name: 'User', description: 'Can read and create. Can update and destroy own folder or documents' })
r3 = Role.create({ name: 'Admin', description: 'Can perform any CRUD operation on any resource' })