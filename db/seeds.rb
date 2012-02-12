# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u1 = User.create!( email: "user1", password: "asdf")
u2 = User.create!( email: "user2", password: "asdf")

b1 = Bit.create!( title: "some bit",
                 code: "Code here \nCode here \nCode here \nCode here \n",
                 description: "Whatever Whatever Whatever Whatever Whatever Whatever Whatever Whatever Whatever Whatever Whatever Whatever Whatever Whatever Whatever Whatever Whatever Whatever Whatever"
      )
b1.user = u1
b1.tag_list = [ "tagTheFirst", "tagTheSecond" ]
b1.save

