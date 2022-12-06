require 'rails_helper'

describe "Index Merchants API" do
  it "can GET all merchants" do
    create_list(:merchant, 3)
    get api_v1_merchants_path

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end
end