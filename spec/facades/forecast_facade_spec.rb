require 'rails_helper'

RSpec.describe ForecastFacade do
  it 'exists' do
    forecast_facade = ForecastFacade.new

    expect(forecast_facade).to be_a ForecastFacade
  end
end