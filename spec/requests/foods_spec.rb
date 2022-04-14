require 'rails_helper'

RSpec.describe "Foods", type: :request do
  context 'testing request' do
    it "GET /foods" do
      get('/foods')
      expect(response).to render_template('index')
      expect(response).to have_http_status(:ok)
    end

    it "GET /foods/:id" do
      get('/foods/1')
      expect(response).to render_template('show')
      expect(response).to have_http_status(:ok)
    end

    it "GET /foods/new" do
      get('/foods/new')
      expect(response).to render_template('new')
      expect(response).to have_http_status(:ok)
    end
  end
end
