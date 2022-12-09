# frozen_string_literal: true

require 'rails_helper'

describe 'Show Items API' do
  context 'given a valid ID' do
    it 'can GET one item by ID' do
      id = create(:item)

      get api_v1_item_path(id)

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end

  context 'given a non-valid ID' do
    it 'returns an error' do
      create(:item)
      get api_v1_item_path(Item.last.id + 1)

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end
  end
end
