class LocationsController < ApplicationController
	def index
		states = CS.states(params[:location]);
		results = [];
		states.each do | state |
			cities = CS.cities(state[0])
			cities.each do | city |
				results.push city
			end
		end
		render json: results
	end
end
