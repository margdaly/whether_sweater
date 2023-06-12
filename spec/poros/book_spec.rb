require 'rails_helper'

RSpec.describe 'Book' do
  describe 'initialize' do
    it 'exists and has attributes' do
      title = "title"
      publisher = ["publisher"]
      isb = ["isbn1", "isbn2"]

      book = Book.new(title, publisher, isb)

      expect(book).to be_a Book
      expect(book.id).to eq(nil)
      expect(book.type).to eq("book")
      expect(book.title).to eq("title")
      expect(book.isbn).to eq(["isbn1", "isbn2"])
      expect(book.publisher).to eq(["publisher"])
    end
  end
end