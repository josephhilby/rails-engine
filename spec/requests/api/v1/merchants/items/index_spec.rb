require 'rails_helper'

describe "Index Merchant_Items API" do
  context 'given a valid merchant ID' do
    it "can GET all items of merchant by ID" do
      id = create(:merchant)
      3.times { create(:item, merchant: id) }

      get api_v1_merchant_items_path(id)

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(items.count).to eq(3)

      items.each do |item|
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
  end

  context 'given a non-valid merchant ID' do
    it 'returns an error' do
      create(:merchant)
      get api_v1_merchant_items_path(Merchant.last.id + 1)

      expect(response).not_to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)

      expect(merchant).to have_key(:errors)
      expect(merchant[:errors]).to be_a(String)
    end
  end
end
