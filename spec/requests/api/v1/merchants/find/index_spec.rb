require 'rails_helper'

describe "Index Merchant_Find API" do
  it "can GET all merchants that match given params" do
    create(:merchant, name: "Johi")
    create(:merchant, name: "John Smith")
    create(:merchant, name: "Littlejohns Jacob")
    create(:merchant, name: "Mike Johnson")
    get '/api/v1/merchants/find_all?name=john'

    # require'pry';binding.pry
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
      expect(merchant[:attributes][:name].downcase.include?('john')).to be(true)
    end
  end
end