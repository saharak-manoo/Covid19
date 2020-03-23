class Integer
  def to_delimited
    ActiveSupport::NumberHelper.number_to_delimited(self)
  end
end