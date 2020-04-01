class Hospital < ApplicationRecord
  acts_as_mappable default_units: :kms,
                   default_formula: :sphere,
                   distance_field_name: :address,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  def price
    min_cost = min_cost.to_i
    max_cost = max_cost.to_i

    if min_cost.zero? && max_cost.zero?
      "ไม่ทราบราคา"
    elsif !min_cost.zero? && !max_cost.zero?
      "#{min_cost.to_delimited} - #{max_cost.to_delimited} บาท"
    elsif !min_cost.zero?
      "#{min_cost.to_delimited} บาท"
    elsif !max_cost.zero?
      "#{max_cost.to_delimited} บาท"
    end  
  end

  def kilometers(lat, long)
    Geocoder::Calculations.distance_between([latitude, longitude], [lat, long])
  end

  def to_km_th(lat, long)
    km = kilometers(lat, long).to_i

    if km.zero?
      'รพ.นี้อยู่ห่างจากคุณไม่ถึง 1 กิโลเมตร'
    else
      "รพ.นี้อยู่ห่างจากคุณประมาณ #{km} กิโลเมตร"
    end
  end

  def last_updated
    (updated_at || DateTime.now).localtime.to_difference_str
  end

  def as_json(options = {})
    if options[:api]
      json = super().except('id')
      json[:price] = price
      json[:kilometers] = kilometers(options[:lat], options[:long])
      json[:kilometer_th] = to_km_th(options[:lat], options[:long])
      json[:last_updated] = last_updated

      json&.with_indifferent_access
    else
      super()
    end   
  end
end