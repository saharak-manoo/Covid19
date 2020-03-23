class String
  def to_key
    self.gsub(/(\s\-|\s)/, "_").downcase
  end

  def to_map_pin
    {
      url: self,
      scaledSize: {
        width: 30,
        height: 30
      }
    }
  end
end