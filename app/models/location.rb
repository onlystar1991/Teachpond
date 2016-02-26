class Location < ActiveRecord::Base
	has_many :posts
	has_many :requests

end
