class World < ApplicationRecord
  def travel_color
    travel_color = "#000"

    case travel
    when 'มีความเสี่ยง'
      travel_color = "#FED023"
    when 'ห้ามเดินทาง'
      travel_color = "#FE205D"
    end
  end

  def last_updated
    (updated_at || DateTime.now).localtime.to_difference_str
  end

  def as_json(options = {})
    if options[:api]
      json = super().except('id')
      json[:confirmed_color] = confirmed.to_covid_color
      json[:healings_color] = healings.to_covid_color
      json[:deaths_color] = deaths.to_covid_color
      json[:recovered_color] = recovered.to_covid_color
      json[:travel_color] = travel_color
      json[:last_updated] = last_updated

      json
    else
      super()
    end   
  end
end