class NewAnnouncementJob < Struct.new(:announcement_id)
  def perform
    announcement = Announcement.find announcement_id

    User.all.each do |user|
      AnnouncementMailer.delay.new_announcement(user, announcement)
    end
  end
end
