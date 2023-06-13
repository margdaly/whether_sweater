require 'rails_helper'

RSpec.describe ActivityService do
  describe '#relaxing_activity' do
    it 'returns a relaxing activity', :vcr do
      relaxing_activity = ActivityService.new.relaxing_activity

      expect(relaxing_activity).to be_a Hash
      expect(relaxing_activity).to have_key :activity
      expect(relaxing_activity[:activity]).to be_a String
      expect(relaxing_activity).to have_key :type
      expect(relaxing_activity[:type]).to eq('relaxation')
      expect(relaxing_activity).to have_key :participants
      expect(relaxing_activity[:participants]).to be_an Integer
      expect(relaxing_activity).to have_key :price
      expect(relaxing_activity[:price].to_f).to be_a Float
    end
  end

  describe '#busywork_activity' do
    it 'returns a busywork activity', :vcr do
      busywork_activity = ActivityService.new.busywork_activity

      expect(busywork_activity).to be_a Hash
      expect(busywork_activity).to have_key :activity
      expect(busywork_activity[:activity]).to be_a String
      expect(busywork_activity).to have_key :type
      expect(busywork_activity[:type]).to eq('busywork')
      expect(busywork_activity).to have_key :participants
      expect(busywork_activity[:participants]).to be_an Integer
      expect(busywork_activity).to have_key :price
      expect(busywork_activity[:price].to_f).to be_a Float
    end
  end

  describe '#recreational_activity' do
    it 'returns a recreational activity', :vcr do
      recreational_activity = ActivityService.new.recreational_activity

      expect(recreational_activity).to be_a Hash
      expect(recreational_activity).to have_key :activity
      expect(recreational_activity[:activity]).to be_a String
      expect(recreational_activity).to have_key :type
      expect(recreational_activity[:type]).to eq('recreational')
      expect(recreational_activity).to have_key :participants
      expect(recreational_activity[:participants]).to be_an Integer
      expect(recreational_activity).to have_key :price
      expect(recreational_activity[:price].to_f).to be_a Float
    end
  end

  describe '#cooking_activity' do
    it 'returns a cooking activity', :vcr do
      cooking_activity = ActivityService.new.cooking_activity

      expect(cooking_activity).to be_a Hash
      expect(cooking_activity).to have_key :activity
      expect(cooking_activity[:activity]).to be_a String
      expect(cooking_activity).to have_key :type
      expect(cooking_activity[:type]).to eq('cooking')
      expect(cooking_activity).to have_key :participants
      expect(cooking_activity[:participants]).to be_an Integer
      expect(cooking_activity).to have_key :price
      expect(cooking_activity[:price].to_f).to be_a Float
    end
  end
end