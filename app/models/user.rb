class User < ActiveRecord::Base
  has_many :attendances
  has_many :camps, :through => :attendances
  has_many :projects, :dependent => :destroy
  has_many :notices
  has_many :thoughts
  has_many :likes
  has_many :talks
  
  validates_presence_of :first_name, :email
  validates_uniqueness_of :email

  default_scope { order('lower(last_name), first_name') }
  scope :organisers, -> { joins(:attendances).where("attendances.organiser = ? and attendances.camp_id = ?", true, Camp.current) }
  
  acts_as_taggable
  acts_as_taggable_on :skills, :interests
  
  def to_s
    full_name
  end
  
  def full_name
    if last_name
      first_name + ' ' + last_name
    else
      first_name
    end
  end
  
  def organiser?
    attendances.exists?(camp_id: Camp.current, organiser: true)
  end
  
  def self.authenticate(param)
    user = find_by_email(param) || find_by_twitter(param)
    user ? user : nil
  end
end
