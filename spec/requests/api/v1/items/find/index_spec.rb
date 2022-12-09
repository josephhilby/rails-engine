require 'rails_helper'

describe "Index Item_Find API" do
  before(:each) do
    create(:item, name: 'Thing One', unit_price: 5.00)
    create(:item, name: 'Athingie', unit_price: 10.00)
    create(:item, name: 'Item', unit_price: 15.00)
    create(:item, name: 'Item One', unit_price: 20.00)
  end
  context 'given valid price params' do
    it "can GET all items that match given min_price" do
      get '/api/v1/items/find_all?min_price=10.00'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(items.count).to eq(3)
      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes][:unit_price] >= 10.00).to be(true)
      end
    end

    it "can GET all items that match given max_price" do
      get '/api/v1/items/find_all?max_price=15.00'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(items.count).to eq(3)
      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes][:unit_price] <= 15.00).to be(true)
      end
    end

    it "can GET all items that match given min & max_price" do
      get '/api/v1/items/find_all?min_price=10.00&max_price=15.00'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(items.count).to eq(2)
      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes][:unit_price] >= 10.00).to be(true)
        expect(item[:attributes][:unit_price] <= 15.00).to be(true)
      end
    end
  end

  context 'given valid name params' do
    it "can GET an item that matches given name" do
      get '/api/v1/items/find_all?name=thing'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(items.count).to eq(2)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes][:name].downcase.include?('thing')).to be(true)
      end
    end
  end

  context 'given price and name params' do
    it 'returns an error' do
      get '/api/v1/items/find_all?name=thing&min_price=10'

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end

    it 'returns an error' do
      get '/api/v1/items/find_all?name=thing&max_price=10'

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end
  end

  context 'given non-valid price params' do
    it 'returns an error' do
      get '/api/v1/items/find_all?max_price=dd'

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)
      # require'pry';binding.pry
      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end

    it 'returns an error' do
      get '/api/v1/items/find_all?min_price=dd'

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end

    it 'returns an error' do
      get '/api/v1/items/find_all?max_price=-5'

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end

    it 'returns an error' do
      get '/api/v1/items/find_all?min_price=-5'

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end
  end

  context 'given non-valid name params' do
    it 'returns an error' do
      get '/api/v1/items/find_all?name=xkcd'

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(response.status).to eq(200)

      expect(item.length).to eq(0)
      expect(item).to be_a(Array)
    end
  end

  context 'given empity price params' do
    it 'returns an error' do
      get '/api/v1/items/find_all?max_price='

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end
  end

  context 'given empity name params' do
    it 'returns an error' do
      get '/api/v1/items/find_all?name='

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end
  end

  context 'given no params' do
    it 'returns an error' do
      get '/api/v1/items/find_all'

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end
  end
end