class Request < ActiveRecord::Base

  #sql relation between tables
  belongs_to :user
  belongs_to :category
  belongs_to :location

  #check validity of fields
  validates :category_id, :presence => true
  validates :title, :presence => true, :length => {:minimum =>5, :maximum => 75}
  validates :description, :presence => true, :length => { :minimum => 20}
  validates :price, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }

end
