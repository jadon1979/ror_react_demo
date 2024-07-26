require 'rails_helper'

RSpec.describe "Api::V1::Companies", type: :request do
  include_context 'has authentication'

  let(:mso) { create(:mso) }
  let(:valid_params) do
    {
      name: Faker::Company.unique.name,
      phone_number: '123-456-7890',
      address_1: '123 Main St',
      address_2: 'Apt 4',
      city: 'Metropolis',
      zip: '12345',
      state_id: create(:state).id
    }
  end
  let(:invalid_params) do
    {
      name: '',
      phone_number: '',
      address_1: '',
      address_2: '',
      city: '',
      zip: ''
    }
  end

  describe "GET /api/v1/msos/:mso_id/companies" do
    it "renders a successful response" do
      create(:company, valid_params.merge(mso: mso))
      get api_v1_mso_companies_url(mso), headers: default_headers
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "paginates results" do
      create_list(:company, 15, mso: mso)
      get api_v1_mso_companies_url(mso), params: { page: 2, per: 5 }, headers: default_headers
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['meta']['pagination']['current_page']).to eq(2)
      expect(json_response['meta']['pagination']['total_pages']).to be > 1
    end
  end

  describe "GET /api/v1/msos/:mso_id/companies/:id" do
    it "renders a successful response" do
      company = create(:company, valid_params.merge(mso: mso))
      get api_v1_mso_company_url(mso, company), headers: default_headers
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "POST /api/v1/msos/:mso_id/companies" do
    context "with valid parameters" do
      it "creates a new Company" do
        expect {
          post api_v1_mso_companies_url(mso), params: { company: valid_params }, headers: default_headers
        }.to change(Company, :count).by(1)
      end

      it "renders a JSON response with the new company" do
        post api_v1_mso_companies_url(mso), params: { company: valid_params }, headers: default_headers
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Company" do
        expect {
          post api_v1_mso_companies_url(mso), params: { company: invalid_params }, headers: default_headers
        }.to change(Company, :count).by(0)
      end

      it "renders a JSON response with errors for the new company" do
        post api_v1_mso_companies_url(mso), params: { company: invalid_params }, headers: default_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe "PATCH /api/v1/msos/:mso_id/companies/:id" do
    context "with valid parameters" do
      let(:new_params) do
        { name: 'Updated Company', city: 'Gotham' }
      end

      it "updates the requested company" do
        company = create(:company, valid_params.merge(mso: mso))
        patch api_v1_mso_company_url(mso, company), params: { company: new_params }, headers: default_headers
        company.reload
        expect(company.name).to eq('Updated Company')
        expect(company.city).to eq('Gotham')
      end

      it "renders a JSON response with the company" do
        company = create(:company, valid_params.merge(mso: mso))
        patch api_v1_mso_company_url(mso, company), params: { company: new_params }, headers: default_headers
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the company" do
        company = create(:company, valid_params.merge(mso: mso))
        patch api_v1_mso_company_url(mso, company), params: { company: invalid_params }, headers: default_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe "DELETE /api/v1/msos/:mso_id/companies/:id" do
    it "destroys the requested company" do
      company = create(:company, valid_params.merge(mso: mso))
      expect {
        delete api_v1_mso_company_url(mso, company), headers: default_headers
      }.to change(Company, :count).by(-1)
    end
  end
end
