class Cancellation
	include ActiveModel::Model

	attr_accessor :requested_leads
	validates_presence_of :requested_leads
end
