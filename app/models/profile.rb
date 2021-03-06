class Profile < ActiveRecord::Base

  #sql relation between tables
  belongs_to :user
  has_many :contracts

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/image/index.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
