# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

rc10 = Camp.find_by_name('Railscamp X') || Camp.create(:name => 'Railscamp X', :location => 'Woodhouse, Piccadilly, Adelaide', :current => true, :time_zone => 'Adelaide', :start_at => '2012-01-13 16:00:00', :end_at => '2012-01-16 10:00:00')
Time.zone = rc10.time_zone

require 'csv'
filename = File.join(Rails.root.to_s, 'db', 'seeds', 'rc10_attendees.csv')
puts "Making sure we have some users for #{rc10.name}..."
CSV.foreach(filename, :headers => true) do |row|
  if rc10.users.find_by_email(row['email']).nil?
    puts "Creating #{row['first_name']} #{row['last_name']}"
    u = rc10.users.create!(
      :first_name => row['first_name'],
      :last_name => row['last_name'],
      :email => row['email'],
      :twitter => row['twitter']
    )
  end
end
puts "Done with users."

%w(ben@hoskings.net
christopher.darroch@gmail.com
sebastian@vonconrad.com
me@keithpitt.com).each do |email|
  puts "Setting #{email} as organiser"
  User.find_by_email!(email).attendances.first.update_attribute(:organiser, true)
end
puts 'Done with organisers.'

cd = User.find_by_email!('christopher.darroch@gmail.com')
svc = User.find_by_email!('sebastian@vonconrad.com')

puts 'Creating Venues'
['Main Hall', 'Henry Rymill room', 'Safe Refuge Area (Rec Room)', 'Pem Fooks room', 'A. J. Peake room (small)', 'Old House Dining Room', 'Old House Lounge Room'].each { |v| rc10.venues.create!(:name => v) unless rc10.venues.find_by_name(v) }
catering = Venue.find_by_name!('Main Hall')

puts 'Creating Events'
events = []
# Saturday
events << {:start_at => "2012-01-14 08:00:00", :end_at => "2012-01-14 09:00:00", :name => "Breakfast", :description => "Saturday breakfast"}
events << {:start_at => "2012-01-14 10:30:00", :end_at => "2012-01-14 11:00:00", :name => "Morning Tea", :description => "Saturday morning tea"}
events << {:start_at => "2012-01-14 12:30:00", :end_at => "2012-01-14 13:00:00", :name => "Lunch", :description => "Saturday lunch"}
events << {:start_at => "2012-01-14 15:00:00", :end_at => "2012-01-14 15:30:00", :name => "Afternoon Tea", :description => "Saturday afternoon tea"}
events << {:start_at => "2012-01-14 18:00:00", :end_at => "2012-01-14 19:00:00", :name => "Dinner", :description => "Saturday dinner"}
# Sunday
events << {:start_at => "2012-01-15 08:00:00", :end_at => "2012-01-15 09:00:00", :name => "Breakfast", :description => "Sunday breakfast"}
events << {:start_at => "2012-01-15 10:30:00", :end_at => "2012-01-15 11:00:00", :name => "Morning Tea", :description => "Sunday morning tea"}
events << {:start_at => "2012-01-15 12:30:00", :end_at => "2012-01-15 13:00:00", :name => "Lunch", :description => "Sunday lunch"}
events << {:start_at => "2012-01-15 15:00:00", :end_at => "2012-01-15 15:30:00", :name => "Afternoon Tea", :description => "Sunday afternoon tea"}
events << {:start_at => "2012-01-15 18:00:00", :end_at => "2012-01-15 19:00:00", :name => "Dinner", :description => "Sunday dinner"}
# Monday
events << {:start_at => "2012-01-16 08:00:00", :end_at => "2012-01-16 09:00:00", :name => "Breakfast", :description => "Monday breakfast. It's all over!"}
events << {:start_at => "2012-01-16 09:30:00", :end_at => "2012-01-16 10:30:00", :name => "Game Over", :description => "RailsCamp is over. Time to pack up and head on out."}
events << {:start_at => "2012-01-16 11:00:00", :end_at => "2012-01-16 11:05:00", :name => "Shuttle Bus to the Airport", :description => "If you need the shuttle bus to the airport, they'll be outside the Main Hall building."}

events.each { |e| Event.create!(e.merge(:camp => rc10, :venue => catering, :user => svc)) }
puts 'Events created.'

puts 'Adding a welcome message'
content = <<-EOS
Kickin&rsquo; in the front seat
Sittin&rsquo; in the back seat
Gotta make my mind up
Which seat can I take?

It's Friday, Friday
Gotta get down on Friday
Everybody's lookin&rsquo; forward to the weekend, weekend
Friday, Friday
Gettin&rsquo; down on Friday
Everybody's lookin&rsquo; forward to the weekend

Partyin&rsquo;, partyin&rsquo; (Yeah)
Partyin&rsquo;, partyin&rsquo; (Yeah)
Fun, fun, fun, fun
Lookin&rsquo; forward to the weekend
EOS

Notice.create!(:title => 'Welcome to Woodhouse', :content => content, :camp => rc10, :user => cd)
puts 'Message created.'
puts 'Done!'
