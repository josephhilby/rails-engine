# frozen_string_literal: true

require 'rails_helper'

describe 'Show Item_Find API' do
  before(:each) do
    create(:item, name: 'Thing One', unit_price: 5.00)
    create(:item, name: 'Athingie', unit_price: 10.00)
    create(:item, name: 'Item', unit_price: 15.00)
    create(:item, name: 'Item One', unit_price: 20.00)
  end
  context 'given valid price params' do
    it 'can GET an item that matches given min_price' do
      get '/api/v1/items/find?min_price=10.00'

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:unit_price] >= 10.00).to be(true)
    end

    it 'can GET an item that matches given max_price' do
      get '/api/v1/items/find?max_price=15.00'

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:unit_price] <= 15.00).to be(true)
    end

    it 'can GET an item that matches given min & max_price' do
      get '/api/v1/items/find?min_price=10.00&max_price=15.00'

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:unit_price] >= 10.00).to be(true)
      expect(item[:attributes][:unit_price] <= 15.00).to be(true)
    end
  end

  context 'given valid name params' do
    it 'can GET an item that matches given min_price' do
      get '/api/v1/items/find?name=thing'

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:name]).to eq('Athingie')
    end
  end

  context 'given non-valid price params' do
    it 'returns an error' do
      get '/api/v1/items/find?max_price=dd'

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end

    it 'returns an error' do
      get '/api/v1/items/find?max_price=5.00&min_price=10.00'

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end
  end

  context 'given non-valid name params' do
    it 'returns an error' do
      get '/api/v1/items/find?name=xkcd'

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response.status).to eq(200)
      # require'pry';binding.pry
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be(nil)
    end
  end

  context 'given empity price params' do
    it 'returns an error' do
      get '/api/v1/items/find?max_price='

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end
  end

  context 'given empity name params' do
    it 'returns an error' do
      get '/api/v1/items/find?max_name='

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end
  end

  context 'given no params' do
    it 'returns an error' do
      get '/api/v1/items/find'

      expect(response).not_to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(item).to have_key(:errors)
      expect(item[:errors]).to be_a(String)
    end
  end
end
