puts "Creating Camp"
camp = Camp.find_or_create_by_name("Railscamp 24",
  location: "Camp Woodfield, Hobart",
  current: true,
  time_zone: "Hobart",
  start_at: "2018-11-23 16:00:00",
  end_at: "2018-11-26 10:00:00",
)
Time.zone = camp.time_zone
puts camp.inspect
puts

puts "Creating organizers"
sam = User.find_or_create_by_email("sj26@sj26.com",
  first_name: "Samuel",
  last_name: "Cochran",
  twitter: "sj26",
)
puts sam.inspect
attendance = sam.attendances.find_or_create_by_camp_id(camp).tap { |attendance| attendance.update_attributes(organiser: true) }
puts attendance.inspect
puts

#puts "Creating attendees"
#require "csv"
#filename = File.join(Rails.root.to_s, "db", "seeds", "attendees.csv")
#CSV.foreach(filename, headers: true) do |row|
#    puts "#{row["first_name"]} #{row["last_name"]}"
#    user = camp.users.find_or_create_by_email(row["email"],
#      first_name: row["first_name"],
#      last_name: row["last_name"],
#      twitter: row["twitter"],
#    )
#    puts user.inspect
#end
#puts

puts "Creating Venues"
main_hall = camp.venues.find_or_create_by_name("Main Hall")
puts

puts "Creating Events"
#events = []
# Friday
#events << {:start_at => "2012-01-13 21:45:00", :end_at => "2012-01-14 03:00:00", :name => "Werewolf", :description => "Quite possibly the best game you'll ever play.", :venue => rec_room, :user => ryanbigg}
#events << {:start_at => "2012-01-13 20:30:00", :end_at => "2012-01-14 00:10:00", :name => "ScotchFTW", :description => "So much scotch.", :venue => rec_room, :user => lachlanhardy}
# Saturday
#events << {:start_at => "2012-01-14 08:00:00", :end_at => "2012-01-14 09:00:00", :name => "Breakfast", :description => "Saturday breakfast"}
#events << {:start_at => "2012-01-14 10:30:00", :end_at => "2012-01-14 11:00:00", :name => "Morning Tea", :description => "Saturday morning tea"}
#events << {:start_at => "2012-01-14 12:30:00", :end_at => "2012-01-14 13:00:00", :name => "Lunch", :description => "Saturday lunch"}
#events << {:start_at => "2012-01-14 15:00:00", :end_at => "2012-01-14 15:30:00", :name => "Afternoon Tea", :description => "Saturday afternoon tea"}
#events << {:start_at => "2012-01-14 18:00:00", :end_at => "2012-01-14 19:00:00", :name => "Dinner", :description => "Saturday dinner"}
# Sunday
#events << {:start_at => "2012-01-15 08:00:00", :end_at => "2012-01-15 09:00:00", :name => "Breakfast", :description => "Sunday breakfast"}
#events << {:start_at => "2012-01-15 10:30:00", :end_at => "2012-01-15 11:00:00", :name => "Morning Tea", :description => "Sunday morning tea"}
#events << {:start_at => "2012-01-15 12:30:00", :end_at => "2012-01-15 13:00:00", :name => "Lunch", :description => "Sunday lunch"}
#events << {:start_at => "2012-01-15 15:00:00", :end_at => "2012-01-15 15:30:00", :name => "Afternoon Tea", :description => "Sunday afternoon tea"}
#events << {:start_at => "2012-01-15 18:00:00", :end_at => "2012-01-15 19:00:00", :name => "Dinner", :description => "Sunday dinner"}
# Monday
#events << {:start_at => "2012-01-16 08:00:00", :end_at => "2012-01-16 09:00:00", :name => "Breakfast", :description => "Monday breakfast. It's all over!"}
#events << {:start_at => "2012-01-16 09:30:00", :end_at => "2012-01-16 10:30:00", :name => "Game Over", :description => "RailsCamp is over. Time to pack up and head on out."}
#events << {:start_at => "2012-01-16 11:00:00", :end_at => "2012-01-16 11:05:00", :name => "Shuttle Bus to the Airport", :description => "If you need the shuttle bus to the airport, they'll be outside the Main Hall building."}
#events.each { |e| Event.create!({:camp => rc10, :venue => catering, :user => svc}.merge(e)) }
puts

puts "Creating Notices"
notice = camp.notices.find_or_create_by_title("Welcome to Woodfield", content: <<TEXT, user: sam)
🌲🌲🌲🌲🌲
🌲🌲🌲🌲🌲
🌲🌲🏕🌲🌲
🌲🌲🌲🌲🌲
🌲🌲🌲🌲🌲
TEXT
puts notice.inspect
puts
puts "All done!"
