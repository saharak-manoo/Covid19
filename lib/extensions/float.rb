class Float
  def to_delimited
    ActiveSupport::NumberHelper.number_to_delimited(self)
  end

  def nil_or_zero?
    (self.nil? or self == 0)
  end
end