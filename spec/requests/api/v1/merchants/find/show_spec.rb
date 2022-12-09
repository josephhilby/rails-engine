# frozen_string_literal: true

require 'rails_helper'

describe 'Show Merchant_Find API' do
  before(:each) do
    create(:merchant, name: 'Johi')
    create(:merchant, name: 'John Smith')
    create(:merchant, name: 'Littlejohns Jacob')
    create(:merchant, name: 'Mike Johnson')
  end
  context 'given valid params' do
    it 'can GET first merchant that match given name' do
      get '/api/v1/merchants/find?name=john'

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
      expect(merchant[:attributes][:name]).to eq('John Smith')
    end
  end

  context 'given non-valid params' do
    it 'returns an error' do
      get '/api/v1/merchants/find?name=xkcd'

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response.status).to eq(200)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be(nil)
    end
  end

  context 'given empity params' do
    it 'returns an error' do
      get '/api/v1/merchants/find?name='

      expect(response).not_to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(merchant).to have_key(:errors)
      expect(merchant[:errors]).to be_a(String)
    end
  end

  context 'given no params' do
    it 'returns an error' do
      get '/api/v1/merchants/find'

      expect(response).not_to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(merchant).to have_key(:errors)
      expect(merchant[:errors]).to be_a(String)
    end
  end
end
