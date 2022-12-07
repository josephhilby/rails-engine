require 'rails_helper'

describe "Show Item_Merchants API" do
  context 'given a valid item ID' do
    it "can GET a merchant by items merchant ID" do
      id = create(:merchant)
      item = create(:item, merchant: id)

      get api_v1_path(item)

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  context 'given a non-valid item ID' do
    it 'returns an error' do
      id = create(:merchant)
      create(:item, merchant: id)

      get api_v1_path(Item.last.id + 1)

      expect(response).not_to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)

      expect(merchant).to have_key(:errors)
      expect(merchant[:errors]).to be_a(String)
    end
  end
end
