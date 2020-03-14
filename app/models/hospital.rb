class Hospital < ApplicationRecord

  def as_json(options = {})
    if options[:api]
      super().except('id')
    else
      super()
    end   
  end
end