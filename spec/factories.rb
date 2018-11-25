require 'faker'

FactoryBot.define do
  factory :attendance do
    user
    camp
    organiser { false }
  end

  factory :camp do
    name { 'Railscamp 9' }
    current { true }
    time_zone { 'Sydney' }
    start_at { 1.day.ago.beginning_of_day + 16.hours }
    end_at { 2.days.from_now.beginning_of_day + 10.hours }
  end

  factory :previous_camp, class: Camp do
    name { 'Railscamp 8' }
    current { false }
    time_zone { 'Sydney' }
    start_at { 1.day.ago.beginning_of_day + 16.hours - 6.months }
    end_at { 2.days.from_now.beginning_of_day + 10.hours - 6.months }
  end

  factory :notice do
    title { Faker::Name.name }
    content { Faker::Lorem.paragraph }
    user
    camp
  end

  factory :project do
    name { Faker::Company.name }
    association :owner, factory: :user
    status { :active }
  end

  factory :event do
    name { Faker::Lorem.words((rand * 8).floor+2).join(" ") }
    description { Faker::Lorem.paragraph }
    camp
    venue
    user
    start_at do
      starting = camp.start_at.to_time
      ending = camp.end_at.to_time
      (starting + (ending - starting) * rand).beginning_of_hour
    end
    end_at { start_at + 1.hour }
  end

  factory :talk, parent: :event, class: Talk do
  end

  factory :venue do
    name { Faker::Lorem.word }
    camp
  end

  factory :user do
    first_name       { Faker::Name.name }
    last_name        { Faker::Name.name }
    email            { Faker::Internet.email }
    twitter          { Faker::Internet.username }
    bio              { Faker::Name.name }
    skill_list       { 'skill_a, skill_b' }
    interest_list    { 'interest_a, interest_b' }
  end
end
