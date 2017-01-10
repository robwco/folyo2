class NewAnnouncementJob < Struct.new(:announcement_id)
  def perform
    return
    
    announcement = Announcement.find announcement_id

    User.find(:email => "robwilliamsgd@gmail.com").each do |user|
      AnnouncementMailer.delay.new_announcement(user, announcement)
    end
  end
end
