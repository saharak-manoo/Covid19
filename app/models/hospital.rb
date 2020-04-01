class Hospital < ApplicationRecord
  acts_as_mappable default_units: :kms,
                   default_formula: :sphere,
                   distance_field_name: :address,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

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

  def as_json(options = {})
    if options[:api]
      json = super().except('id')
      json[:kilometers] = kilometers(options[:lat], options[:long])
      json[:kilometer_th] = to_km_th(options[:lat], options[:long])
      
      json
    else
      super()
    end   
  end
end