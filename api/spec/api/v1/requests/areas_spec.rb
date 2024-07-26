require 'rails_helper'

RSpec.describe "Api::V1::Areas", type: :request do
  include_context 'has authentication'

  let(:mso) { create(:mso) }
  let(:state) { create(:state) }
  let(:valid_params) do
    {
      name: Faker::Address.unique.community,
      address_1: '123 Main St',
      address_2: 'Apt 4',
      city: 'Metropolis',
      state_id: state.id,
      zip: '12345'
    }
  end
  let(:invalid_params) do
    {
      name: '',
      address_1: '',
      address_2: '',
      city: '',
      state_id: nil,
      zip: ''
    }
  end

  describe "GET /api/v1/msos/:mso_id/areas" do
    it "renders a successful response" do
      create(:area, valid_params.merge(mso: mso))
      get api_v1_mso_areas_url(mso), headers: default_headers
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "paginates results" do
      create_list(:area, 15, mso: mso)
      get api_v1_mso_areas_url(mso), params: { page: 2, per: 5 }, headers: default_headers
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['meta']['pagination']['current_page']).to eq(2)
      expect(json_response['meta']['pagination']['total_pages']).to be > 1
    end
  end

  describe "GET /api/v1/msos/:mso_id/areas/:id" do
    it "renders a successful response" do
      area = create(:area, valid_params.merge(mso: mso))
      get api_v1_mso_area_url(mso, area), headers: default_headers
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "POST /api/v1/msos/:mso_id/areas" do
    context "with valid parameters" do
      it "creates a new Area" do
        expect {
          post api_v1_mso_areas_url(mso), params: { area: valid_params }, headers: default_headers
        }.to change(Area, :count).by(1)
      end

      it "renders a JSON response with the new area" do
        post api_v1_mso_areas_url(mso), params: { area: valid_params }, headers: default_headers
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Area" do
        expect {
          post api_v1_mso_areas_url(mso), params: { area: invalid_params }, headers: default_headers
        }.to change(Area, :count).by(0)
      end

      it "renders a JSON response with errors for the new area" do
        post api_v1_mso_areas_url(mso), params: { area: invalid_params }, headers: default_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe "PATCH /api/v1/msos/:mso_id/areas/:id" do
    context "with valid parameters" do
      let(:new_params) do
        { name: 'Updated Area', city: 'Gotham' }
      end

      it "updates the requested area" do
        area = create(:area, valid_params.merge(mso: mso))
        patch api_v1_mso_area_url(mso, area), params: { area: new_params }, headers: default_headers
        area.reload
        expect(area.name).to eq('Updated Area')
        expect(area.city).to eq('Gotham')
      end

      it "renders a JSON response with the area" do
        area = create(:area, valid_params.merge(mso: mso))
        patch api_v1_mso_area_url(mso, area), params: { area: new_params }, headers: default_headers
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the area" do
        area = create(:area, valid_params.merge(mso: mso))
        patch api_v1_mso_area_url(mso, area), params: { area: invalid_params }, headers: default_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe "DELETE /api/v1/msos/:mso_id/areas/:id" do
    it "destroys the requested area" do
      area = create(:area, valid_params.merge(mso: mso))
      expect {
        delete api_v1_mso_area_url(mso, area), headers: default_headers
      }.to change(Area, :count).by(-1)
    end
  end
end