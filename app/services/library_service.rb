class LibraryService
  def get_city_books(location, quantity)
    get_url("/search.json?q=#{location}&limit=#{quantity}")
    # get_url("/search.json?q=subject:#{location}&limit=#{quantity}&fields=title,isbn,publisher")
  end

  private

  def conn 
    Faraday.new(url: 'https://openlibrary.org')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
