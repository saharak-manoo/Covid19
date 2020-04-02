class ThailandCase < ApplicationRecord
  validates :place_name, presence: true
  acts_as_mappable default_units: :kms,
                   default_formula: :sphere,
                   distance_field_name: :address,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  def status_color
    status_color = "#000"

    case status
    when "ยืนยัน"
      status_color = "#00EC64"
    when "ต้องสงสัย" 
      status_color = "#9412F5"
    when "ไม่มีข้อมูลผู้ติดเชื้อพื้นที่"
      status_color = "#129FF5"
    when "ไม่ระบุพื้นที่"
      status_color = "#F55E12"
    end
  end

  def pin
    '/confirmed.svg'.to_map_pin
  end

  def date_diff_str
    date.to_difference_str
  end

  def kilometers(lat, long)
    Geocoder::Calculations.distance_between([latitude, longitude], [lat, long])
  end

  def to_km_th(lat, long)
    km = kilometers(lat, long).to_i

    if km.zero?
      'ไม่ถึง 1 กิโลเมตร'
    else
      "ประมาณ #{km} กิโลเมตร"
    end
  end

  def last_updated
    (updated_at || DateTime.now).localtime.to_difference_str
  end

  def as_json(options = {})
    if options[:api]
      json = super().except('id')
      if options[:lat].present? && options[:long].present?
        json[:kilometers] = kilometers(options[:lat], options[:long])
        json[:kilometer_th] = to_km_th(options[:lat], options[:long])
      end

      json[:status_color] = status_color
      json[:pin] = pin
      json[:date_diff_str] = date_diff_str
      json[:last_updated] = last_updated

      json&.with_indifferent_access
    else
      super()
    end   
  end
end