class ActivityService
  def relaxing_activity
    get_url("/api/activity?type=relaxation")
  end

  def busywork_activity
    get_url("/api/activity?type=busywork")
  end

  def cooking_activity
    get_url("/api/activity?type=cooking")
  end

  def recreational_activity
    get_url("/api/activity?type=recreational")
  end

  private

  def conn 
    Faraday.new(url: 'http://www.boredapi.com')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
