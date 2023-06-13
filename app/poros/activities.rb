class Activities 
  attr_reader :id, :type, :destination, :forecast, :activities

  def initialize(destination, forecast, activities)
    @destination = destination
    @forecast = forecast
    @activities = activities
    @id = nil
  end
end
