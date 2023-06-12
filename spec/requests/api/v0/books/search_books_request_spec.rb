require 'rails_helper'

RSpec.describe 'Books API' do
  describe 'GET /books-search' do
    it 'sends a list of books', :vcr do
      location = 'denver,co'

      get "/api/v0/books-search?location=#{location}&quantity=5"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      payload = JSON.parse(response.body, symbolize_names: true)

      expect(payload).to be_a Hash
      expect(payload).to have_key :data

      data = payload[:data]

      expect(data).to be_a Hash
      expect(data).to have_key :id
      expect(data[:id]).to eq(nil)
      expect(data).to have_key :type
      expect(data[:type]).to eq('books')
      expect(data).to have_key :attributes
      expect(data[:attributes]).to be_a Hash

      attributes = data[:attributes]
      expect(attributes).to have_key :destination
      expect(attributes[:destination]).to be_a String

      expect(attributes).to have_key :forecast
      expect(attributes[:forecast]).to be_a Hash
      expect(attributes[:forecast]).to have_key :summary
      expect(attributes[:forecast][:summary]).to be_a String
      expect(attributes[:forecast]).to have_key :temperature
      expect(attributes[:forecast][:temperature]).to be_a String

      expect(attributes).to have_key :total_books_found
      expect(attributes[:total_books_found]).to be_a Integer

      expect(attributes).to have_key :books
      expect(attributes[:books]).to be_an Array
      expect(attributes[:books].count).to eq(5)
      attributes[:books].each do |book|
        expect(book).to be_a Hash
        expect(book).to have_key :isbn
        expect(book[:isbn]).to be_a Array
        expect(book[:isbn].count).to eq(2)
        expect(book[:isbn].first).to be_a String
        expect(book[:isbn].last).to be_a String

        expect(book).to have_key :title
        expect(book[:title]).to be_a String

        expect(book).to have_key :publisher
        expect(book[:publisher]).to be_a Array
        expect(book[:publisher].count).to eq(1)
        expect(book[:publisher].first).to be_a String
      end
    end
  end
end