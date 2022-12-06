require 'rails_helper'

describe "Index Merchants API" do
  context 'given a valid ID' do
    it "can GET one merchant by ID" do
      id = create(:merchant)
      get api_v1_merchant_path(id)

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  context 'given a non-valid ID' do
    it 'returns an error' do
      10.times { create(:merchant) }
      get api_v1_merchant_path(Merchant.last.id + 1)

      expect(response).not_to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)

      expect(merchant).to have_key(:errors)
      expect(merchant[:errors]).to be_a(String)
    end
  end
end