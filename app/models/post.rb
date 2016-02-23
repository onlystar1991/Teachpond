class Post < ActiveRecord::Base

  #sql relation between tables
  belongs_to :user
  belongs_to :category


  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/default_post_image.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  #check validity of fields
  validates :category_id, :presence => true
  validates :title, :presence => true, :length => {:minimum =>5, :maximum => 50}
  validates :description, :presence => true, :length => { :minimum => 20 }
  validates :experience, :presence => true, :length => { :minimum => 20 }
  validates :years_experience, :presence => true
  validates :price, :presence => true

end
