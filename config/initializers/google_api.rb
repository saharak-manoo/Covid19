class GoogleApi

  def self.client
    EasyTranslate.api_key = ENV['google_api_key']
  end

  def self.session
    session = GoogleDrive::Session.from_service_account_key('config/config.json')
  end

  def self.translate(text = 'Hi')
    client
    EasyTranslate.translate(text, to: :th)
  end

  def self.sheets(name = 'thailand covid-19 infected')
    spreadsheet = session.spreadsheet_by_title(name)

    return spreadsheet.worksheets.first, spreadsheet.modified_time.localtime
  end

  def self.seed_file
    worksheet, updated_at = sheets
    values = Covid.thai_summary

    values.each_with_index do |value, index|
      index += 2

      worksheet["A#{index}"] = value[:province] == "กรุงเทพฯ" ? 'กรุงเทพมหานคร' : value[:province]
      worksheet["B#{index}"] = value[:province_eng]
      worksheet["C#{index}"] = value[:infected]
    end

    worksheet.save
  end

  def self.read
    data = []
    worksheet, updated_at = sheets
    rows = worksheet.rows

    rows.each_with_index do |row, index|
      next if index == 0

      infected = row[2].to_i || 0
      data << {
        name: row[0],
        name_eng: row[1],
        infected: infected,
        infected_color: infected.to_covid_color,
      }
    end

    {
      updated_at: updated_at,
      provinces: data
    }
  end
end