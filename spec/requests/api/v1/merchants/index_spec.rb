require 'rails_helper'

describe "Index Merchants API" do
  it "can GET a list of merchants" do
    create_list(:merchant, 3)

    get api_v1_merchants_path

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)

      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_a(String)

      expect(merchant).to have_key(:created_at)
      expect(merchant[:created_at]).to be_a(String)

      expect(merchant).to have_key(:updated_at)
      expect(merchant[:updated_at]).to be_an(String)
    end
  end
end