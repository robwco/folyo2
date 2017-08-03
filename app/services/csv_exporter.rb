require 'csv'

class CsvExporter

  extend UsersHelper   

  def self.export_users
    csv_file = CSV.generate do |csv|
      csv << column_headers

      User.all.each do |user|
        csv << data_row(user)
      end
    end

    csv_file
  end

  private
    def self.column_headers
      [
        "Date signed up",
        "Full Name",
        "First Name",
        "Email"
      ]
    end
    def self.data_row(user)
      [
        user.created_at.strftime("%m/%Y"),
        user.name,
        first_name(user.name),
        user.email
      ]
    end
end