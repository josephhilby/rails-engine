require 'rails_helper'

describe "Update Items API" do
  context 'given a valid ID and params' do
    it "can PATCH/PUT an existing item" do
      id = create(:item).id
      previous_name = Item.last.name
      item_params = { name: "New Item Name One" }

      headers = {"CONTENT_TYPE" => "application/json"}
      patch api_v1_item_path(id), headers: headers, params: JSON.generate({item: item_params})
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("New Item Name One")
    end
  end

  context 'given a non-valid ID' do
    it 'returns an error' do
      merchant_id = create(:merchant).id
      create(:item).id
      item_params = { name: "New Item Name Two", merchant_id: merchant_id }

      headers = {"CONTENT_TYPE" => "application/json"}
      patch api_v1_item_path(Item.last.id + 1), headers: headers, params: JSON.generate({item: item_params})

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful
      expect(response.status).to eq(404)
      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end
  end

  context 'given non-valid params' do
    it 'returns an error' do
      create(:merchant)
      id = create(:item).id
      item_params = { name: "New Item Name Three", merchant_id: Merchant.last.id + 1 }

      headers = {"CONTENT_TYPE" => "application/json"}
      patch api_v1_item_path(id), headers: headers, params: JSON.generate({item: item_params})

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).not_to be_successful
      expect(response.status).to eq(404)
      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end
  end
end