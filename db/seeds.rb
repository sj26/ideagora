puts "Creating Camp"
camp = Camp.find_or_create_by!(name: "Railscamp 24") do |camp|
  camp.location = "Camp Woodfield, Hobart"
  camp.current = true
  camp.time_zone = "Hobart"
  camp.start_at = "2018-11-23 16:00:00"
  camp.end_at = "2018-11-26 10:00:00"
end
Time.zone = camp.time_zone
puts camp.inspect
puts

puts "Creating organizers"
organiser = User.find_or_create_by!(email: "sj26@sj26.com") do |user|
  user.first_name = "Samuel"
  user.last_name = "Cochran"
  user.twitter = "sj26"
end
puts organiser.inspect
attendance = organiser.attendances.find_or_create_by!(camp: camp)
attendance.update!(organiser: true)
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
main_hall = camp.venues.find_or_create_by!(name: "Main Hall")
chapel = camp.venues.find_or_create_by!(name: "Chapel")
puts

puts "Creating Events"
# Friday
camp.events.find_or_create_by!(start_at: "2018-11-23 18:30:00", end_at: "2018-11-23 19:30:00", name: "Dinner", venue: main_hall, user: organiser)
camp.events.find_or_create_by!(start_at: "2018-11-23 21:30:00", end_at: "2018-11-23 22:00:00", name: "Antipasto", venue: main_hall, user: organiser)

camp.events.find_or_create_by!(start_at: "2018-11-24 08:30:00", end_at: "2018-11-24 09:30:00", name: "Breakfast", venue: main_hall, user: organiser)
camp.events.find_or_create_by!(start_at: "2018-11-24 12:30:00", end_at: "2018-11-24 13:30:00", name: "Lunch", venue: main_hall, user: organiser)
camp.events.find_or_create_by!(start_at: "2018-11-24 18:30:00", end_at: "2018-11-24 19:30:00", name: "Dinner", venue: main_hall, user: organiser)
camp.events.find_or_create_by!(start_at: "2018-11-24 21:30:00", end_at: "2018-11-24 22:00:00", name: "Antipasto", venue: main_hall, user: organiser)

camp.events.find_or_create_by!(start_at: "2018-11-25 08:30:00", end_at: "2018-11-25 09:30:00", name: "Breakfast", venue: main_hall, user: organiser)
camp.events.find_or_create_by!(start_at: "2018-11-25 12:30:00", end_at: "2018-11-25 13:30:00", name: "Lunch", venue: main_hall, user: organiser)
camp.events.find_or_create_by!(start_at: "2018-11-25 14:00:00", end_at: "2018-11-25 16:00:00", name: "Ruby Australia AGM", venue: chapel, user: organiser)
camp.events.find_or_create_by!(start_at: "2018-11-25 17:30:00", end_at: "2018-11-25 18:30:00", name: "Demos", venue: main_hall, user: organiser)
camp.events.find_or_create_by!(start_at: "2018-11-25 18:30:00", end_at: "2018-11-25 19:30:00", name: "Dinner", venue: main_hall, user: organiser)
camp.events.find_or_create_by!(start_at: "2018-11-25 21:30:00", end_at: "2018-11-25 22:00:00", name: "Antipasto", venue: main_hall, user: organiser)

camp.events.find_or_create_by!(start_at: "2018-11-26 08:30:00", end_at: "2018-11-26 09:30:00", name: "Breakfast", venue: main_hall, user: organiser)
camp.events.find_or_create_by!(start_at: "2018-11-26 10:00:00", end_at: "2018-11-26 10:30:00", name: "Bus departs", venue: main_hall, user: organiser)
puts

puts "Creating Notices"
notice = camp.notices.find_or_create_by!(title: "Welcome to Woodfield") do |notice|
  notice.user = organiser
  notice.content = <<~TEXT
    🌲🌲🌲🌲🌲
    🌲🌲🌲🌲🌲
    🌲🌲🏕🌲🌲
    🌲🌲🌲🌲🌲
    🌲🌲🌲🌲🌲
  TEXT
end
puts notice.inspect
puts
puts "All done!"
