class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #sql relation between tables
  has_one :profile, dependent: :destroy
  before_create :build_profile
  has_many :posts, dependent: :destroy
  has_many :requests, dependent: :destroy
end
