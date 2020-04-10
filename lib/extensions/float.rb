class Float
  def to_delimited
    ActiveSupport::NumberHelper.number_to_delimited(self)
  end

  def nil_or_zero?
    (self.nil? or self == 0)
  end

  def to_age_covid_color
    color = "#000"

    case self
    when 0.0..0.1
      color = "#9412F5"
    when 0.2..0.3
      color = "#772AFE"
    when 0.4..0.5
      color = "#FE0A37"
    when 0.6..0.7
      color = "#FC4B13"
    when 0.8..0.9
      color = "#FC3313"
    when 0.10..1.00
      color = "#FC9613"
    else
      color = "#000"
    end
  end
end