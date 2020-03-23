class String
  def to_key
    self.gsub(/(\s\-|\s)/, "_").tableize
  end
end