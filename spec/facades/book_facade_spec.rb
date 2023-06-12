require 'rails_helper'

RSpec.describe 'Book Facade' do
  it 'exists' do
    book_facade = BookFacade.new

    expect(book_facade).to be_a BookFacade
  end

  describe '#get_city_books' do
    it 'returns a list of books for a city', :vcr do
      books = BookFacade.new.get_city_books('denver,co', '5')

      expect(books).to be_an Array
      expect(books.count).to eq(5)
      expect(books.first).to be_a Book
      expect(books.first.id).to eq(nil)
      expect(books.first.type).to eq("book")
      expect(books.first.title).to be_a String
      expect(books.first.publisher).to be_an Array
    end
  end

  describe 'current_weather' do
    it 'returns a weather object', :vcr do
      weather = BookFacade.new.current_weather('denver,co')

      expect(weather).to be_a Weather
      expect(weather.id).to eq(nil)
      expect(weather.type).to eq("weather")
      expect(weather.current_weather).to be_a Hash
      expect(weather.daily_weather).to be_an Array
      expect(weather.hourly_weather).to be_an Array
    end
  end
end