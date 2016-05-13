class Project < ActiveRecord::Base

	belongs_to :user
	belongs_to :listing_package

	has_attached_file :company_logo, :styles => { :medium => "190x190>", :thumb => "190x190>" }
	has_attached_file :photo, :styles => { :medium => "190x190>", :thumb => "190x190>" }

	validates :title, presence: { message: "'What kind of help do you need?' is required." }
	validates :goals, presence: { message: "'What are you trying to accomplish?' is required." }
	validates :examples, presence: { message: "'What are some examples (logos, sites, apps, etc.) that you like?' is required." }
	validates :deadline, presence: { message: "'What is the target deadline and why?' is required." }
	validates :budget, presence: { message: "'What type of budget do you have for this project?' is required." }
	validates :deliverables, presence: { message: "'What kind of deliverables do you expect?' is required." }
	validates :name, presence: { message: "Your name is required." }
	validates :email, presence: { message: "Your email is required." }
	validates :organization, presence: { message: "Your organization name is required." }
	validates :website, presence: { message: "Your website is required." }
end
