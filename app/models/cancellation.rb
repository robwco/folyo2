class Cancellation
	#Cancellation reasons
	NOT_ENOUGH_RESPONSES = 0
	WRONG_LEAD_TYPES = 1
	HIGHER_QUALITY_LEADS = 2
	IM_BOOKED = 3

	include ActiveModel::Model

	attr_accessor :requested_leads
	validates_presence_of :requested_leads
end
