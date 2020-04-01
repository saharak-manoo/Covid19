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
    "รพ.นี้อยู่ห่างจากคุณประมาณ #{kilometers(lat, long).to_i} กิโลเมตร"
  end  

  def as_json(options = {})
    if options[:api]
      super().except('id')
    else
      super()
    end   
  end
end