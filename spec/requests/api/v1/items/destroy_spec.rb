require 'rails_helper'

describe "Destroy items API" do
  it "can DELETE an item" do
    item = create(:item)

    expect{ delete api_v1_item_path(item) }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end