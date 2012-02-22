# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u1 = User.create!( email: "default_user", password: "ueAvpNaGxDsTFYxQasJSQLxkq6E2IBMpmsn4YH3B")
u1.admin = true;
u1.save
u2 = User.create!( email: "user2", password: "asdf")

( 1..50 ).each do |i|
  b = Bit.create!( title: i.to_s + " Easier end and beginning of line movement",
                   code: "if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif",
                   description: i.to_s + "For such common operations, $ and ^ are way too far away from the home row, and require a same-hand key combo.
                   
Seems silly.

This line remaps it to the intuitive shift-h and shift-l (H and L).", user: u1
        )
  #b.user = u1
  b.tag_list = [ "tagTheFirst", "tagTheSecond" ]
  if( i % 2 == 0)
    b.tag_list.push "mod2"
  end
  if( i % 3 == 0)
    b.tag_list.push "mod3"
  end
  if( i % 4 == 0)
    b.tag_list.push "mod4"
  end
  b.save
end

