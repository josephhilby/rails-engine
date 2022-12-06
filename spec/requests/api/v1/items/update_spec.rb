require 'rails_helper'

describe "Update Items API" do
  it "can PATCH/PUT an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "New Item Name" }
    headers = {"CONTENT_TYPE" => "application/json"}

    # We include this header to make sure that these params are passed as JSON rather than as plain text
    patch api_v1_item_path(id), headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("New Item Name")
  end
end