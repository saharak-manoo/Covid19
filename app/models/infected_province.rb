class InfectedProvince < ApplicationRecord
  validates_uniqueness_of :date, scope: :name

  def yesterday
    yesterday = InfectedProvince.find_by(date: Date.yesterday, name: name)
  end

  def infected_add_today
    (infected - (yesterday&.infected || 0)).non_negative
  end

  def man_total_add_today
    (man_total - (yesterday&.man_total || 0)).non_negative
  end

  def woman_total_add_today
    (woman_total - (yesterday&.woman_total || 0)).non_negative
  end

  def no_gender_total_add_today
    (no_gender_total - (yesterday&.no_gender_total || 0)).non_negative
  end

  def last_updated
    (updated_at || DateTime.now).localtime.to_difference_str
  end

  def as_json(options = {})
    if options[:api]
      json = super().except('id')
      json[:infected_add_today] = infected_add_today
      json[:man_total_add_today] = man_total_add_today
      json[:woman_total_add_today] = woman_total_add_today
      json[:no_gender_total_add_today] = no_gender_total_add_today
      json[:infected_color] = infected.to_covid_color
      json[:man_total_color] = man_total.to_covid_color
      json[:woman_total_color] = woman_total.to_covid_color
      json[:no_gender_total_color] = no_gender_total.to_covid_color
      json[:last_updated] = last_updated

      json&.with_indifferent_access
    else
      super()
    end
  end
end