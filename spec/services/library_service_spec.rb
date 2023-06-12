require 'rails_helper'

RSpec.describe 'Library Service' do
  describe '#get_books' do
    it 'returns books for a city', :vcr do
      city = 'denver, co'
      library_service = LibraryService.new
      results = library_service.get_books(city)

      expect(results).to be_a Hash
      expect(results).to have_key :numFound
      expect(results[:numFound]).to be_an Integer

      expect(results).to have_key :docs
      expect(results[:docs]).to be_an Array
      expect(results[:docs].count).to eq(5)
      results[:docs].each do |book|
        expect(book).to be_a Hash
        expect(book).to have_key :title
        expect(book[:title]).to be_a String
        expect(book).to have_key :isbn
        expect(book[:isbn]).to be_an Array
        expect(book[:isbn].count).to eq(2)
        expect(book[:isbn].first).to be_a String
        expect(book[:isbn].last).to be_a String
        expect(book).to have_key :publisher
        expect(book[:publisher]).to be_an Array
        expect(book[:publisher].count).to eq(1)
        expect(book[:publisher].first).to be_a String
      end
    end
  end
end