class Request < ActiveRecord::Base

  #sql relation between tables
  belongs_to :user
  belongs_to :category
  belongs_to :location

  #check validity of fields
  validates :category_id, :presence => true
  validates :title, :presence => true, :length => {:minimum =>5, :maximum => 100}
  validates :description, :presence => true, :length => { :minimum => 20 }
  validates :price, :presence => true

end
