class ActiveSupport::TimeWithZone
  def as_json(options = {})
    strftime('%F')
  end
end