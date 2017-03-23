class Page < ActiveRecord::Base
  has_many :sections
  belongs_to :subject
  has_and_belongs_to_many :editors , :class_name => "AdminUser"

  #there, we change :admin_users with :editors to make some scence and be much more descriptive.
  #so, we should refer to pages that editors is actually admin_users

  #if you named the join table different name that not following rails convention
  #you should specify that name
    # join_table => "#table_name"

    # -------------------------------------------------- #

  # Sort the pages that belongs to specific subject
    # if first subject hss 3 pages and second subject has 2,
        #the firt page's position in first subject will be 1 and
        #the firt page's position in second subject will be 1.
  acts_as_list :scope => :subject

  before_validation :add_default_permalink
  after_save :touch_subject
  after_destroy :delete_related_sections

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_presence_of :permalink
  validates_length_of :permalink, :within => 3..255
  # use presence_of with length_of to disallow spaces
  validates_uniqueness_of :permalink
  # for unique values by subject use ":scope => :subject_id"

  scope :visible , lambda{where(:visible => true)}
  scope :invisible , lambda{where(:visible => false)}
  scope :sorted , lambda {order("pages.position ASC")}
  scope :newest_first , lambda {order("pages.created_at DESC")}

  private
    def add_default_permalink
      if permalink.blank?
        self.permalink = "#{id}-#{name.parameterize}"
      end
    end

    def touch_subject
        # touch is similar to:
        # subject.update_attribute(:updated_at, Time.now)
        subject.touch
    end

    def delete_related_sections
      self.sections.each do |section|
        # Or perhaps instead of destroy, you would
        # move them to a another page.
        # section.destroy
      end
    end

end
