require 'rails_helper'

describe "Index Merchant_Itemss API" do
  it "can GET all items of merchant by ID" do
    id = create(:merchant)
    3.times { create(:item, merchant: id) }

    get api_v1_merchant_items_path(id)

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)

      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)

      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)

      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_a(Float)

      expect(item).to have_key(:merchant_id)
      expect(item[:merchant_id]).to be_a(Integer)
      expect(item[:merchant_id]).to eq(id.id)

      expect(item).to have_key(:created_at)
      expect(item[:created_at]).to be_a(String)

      expect(item).to have_key(:updated_at)
      expect(item[:updated_at]).to be_an(String)
    end
  end
end