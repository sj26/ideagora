require "#{Rails.root}/app/helpers/users_helper"
include UsersHelper

namespace :gravatar do
  desc 'setup gravatar for camp attendees'
  task :grab => :environment do
    require 'open-uri'

    User.where(:avatar => nil).each do |user|
      path = "#{Rails.root}/public/avatars/#{user.id}"
      img_path = "#{path}/128.jpg"
      next if File.exists?(img_path)
      
      system "mkdir #{path}"
      open(img_path, 'wb') do |file|
        file << open(get_gravatar(user, 128)).read
      end
      user.update_attribute(:avatar, "/avatars/#{user.id}/128.jpg")
      puts "User #{user.id} updated"
    end
  end
end