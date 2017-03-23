class Subject < ActiveRecord::Base
  # Could delete related pages automatically
  # whenever a subject is deleted:
  # has_many :pages, :dependent => :destroy
  
  has_many :pages

  #Sort the subjects via position
    #so if we change the the first subject position to 2, the second subject position will be 1
  acts_as_list

  # Don't need to validate (in most cases):
  #   ids, foreign keys, timestamps, booleans, counters
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
    # validates_presence_of vs. validates_length_of :minimum => 1
    # different error messages: "can't be blank" or "is too short"
    # validates_length_of allows strings with only spaces!

  #Named Scopes
  scope :visible , lambda{where(:visible => true)}
  scope :invisible , lambda{where(:visible => false)}
  scope :sorted , lambda {order("subjects.position ASC")}
  scope :newest_first , lambda {order("subjects.created_at DESC")}
  scope :search , lambda {|query|
    where(["name LIKE ?" , "%#{query}%"])
  }

end
