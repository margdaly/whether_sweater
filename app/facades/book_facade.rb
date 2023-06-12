class BookFacade
  def get_city_books(location, quantity)
    data = library_service.get_city_books(location, quantity)
    data[:docs].map do |book_data|

      Book.new(book_data[:title], book_data[:publisher])
    end
  end

  

  private

  def library_service
    @library_service ||= LibraryService.new
  end
end