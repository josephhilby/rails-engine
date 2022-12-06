require 'rails_helper'
require 'faker'

describe "Create Items API" do
  it "can POST a new item" do
    id = create(:merchant).id
    item_params = ({
        name: Faker::Commerce.product_name,
        description: Faker::Marketing.buzzwords,
        unit_price: Faker::Number.within(range: 10..1_000),
        merchant_id: id
      })
    headers = {"CONTENT_TYPE" => "application/json"}

    # We include this header to make sure that these params are passed as JSON rather than as plain text
    post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end
end