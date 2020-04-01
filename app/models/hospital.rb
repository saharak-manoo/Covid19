class Hospital < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  acts_as_mappable default_units: :kms,
                   default_formula: :sphere,
                   distance_field_name: :address,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  def price
    if min_cost.zero? && max_cost.zero?
      "ไม่ทราบราคา"
    elsif !min_cost.zero? && !max_cost.zero?
      "#{number_to_currency(min_cost, unit: '')} - #{number_to_currency(max_cost, unit: '')} บาท"
    elsif !min_cost.zero?
      "#{number_to_currency(min_cost, unit: '')} บาท"
    elsif !max_cost.zero?
      "#{number_to_currency(max_cost, unit: '')} บาท"
    end  
  end

  def kilometers(lat, long)
    Geocoder::Calculations.distance_between([latitude, longitude], [lat, long])
  end

  def to_km_th(lat, long)
    km = kilometers(lat, long).to_i

    if km.zero?
      'อยู่ห่างจากคุณไม่ถึง 1 กิโลเมตร'
    else
      "อยู่ห่างจากคุณประมาณ #{km} กิโลเมตร"
    end
  end

  def last_updated
    (updated_at || DateTime.now).localtime.to_difference_str
  end

  def as_json(options = {})
    if options[:api]
      json = super().except('id')
      json[:price] = price
      if options[:lat].present? && options[:long].present?
        json[:kilometers] = kilometers(options[:lat], options[:long])
        json[:kilometer_th] = to_km_th(options[:lat], options[:long])
      end  
      json[:last_updated] = last_updated

      json&.with_indifferent_access
    else
      super()
    end   
  end
end