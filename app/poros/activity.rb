class Activity
  attr_reader :id, :type, :participants, :price

  def initialize(activity_data)
    @id = nil
    @type = activity_data[:type]
    @particiapants = activity_data[:participants]
    @price = activity_data[:price]
  end
end
