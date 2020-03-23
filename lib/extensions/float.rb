class Float
  def to_delimited
    ActiveSupport::NumberHelper.number_to_delimited(self)
  end
end