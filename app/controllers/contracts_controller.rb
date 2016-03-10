class ContractsController < ApplicationController

	def pay
		contract = current_user.profile.contract.build()
		contract.amount = params[:amount]
		contract.teacher_id = params[:profile_id]
		contract.status = 0
		if contract.save
			render json: {
				message: "success"
			}
		else
			render json: {
				message: "fail"
			}
		end
	end

	def give_feedback
		contract = Contract.find(params[:contract_id])
		if contract.status == 0
			render json: {
				message: "can't give feedback"
			}
		else
			contract.update(rate: params[:rate])
		end
	end

end
