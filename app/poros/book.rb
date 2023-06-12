class Book
  attr_reader :id, :type, :title, :publisher#, :isbn

  def initialize(title, publisher)#, isbn)
    @id = nil
    @type = 'book'
    @title = title
    @publisher = publisher
    # @isbn = isbn
  end
end