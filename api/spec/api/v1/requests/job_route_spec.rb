require 'rails_helper'

RSpec.describe "Api::V1::JobRoute", type: :request do
  include_context 'has authentication'

  let(:mso) { create(:mso) }
  let(:company) { create(:company, mso: mso) }

  let(:valid_params) do
    {
      user_id: default_user.id,
      area_id: create(:area).id,
      tech_id: '12345',
      account_number: '54321',
      job_type: 1,
      first_name: 'John',
      last_name: 'Doe',
      address: '123 Main St',
      city: 'Metropolis',
      zip: '12345',
      home_phone: '123-456-7890',
      other_phonne: '098-765-4321',
      job_date: Time.now,
      job_number: 'JOB123',
      status: 'pending'.to_sym,
      time_frame: '8-10am',
      time_started: Time.now,
      time_completed: Time.now + 1.hour,
      hhc_completed: true
    }
  end
  let(:invalid_params) do
    {
      user_id: nil,
      tech_id: '',
      account_number: '',
      job_type: nil,
      first_name: '',
      last_name: '',
      address: '',
      city: '',
      zip: '',
      home_phone: '',
      other_phonne: '',
      job_date: nil,
      job_number: '',
      status: 'pending'.to_sym,
      time_frame: '',
      time_started: nil,
      time_completed: nil,
      hhc_completed: nil
    }
  end

  describe "GET /api/v1/msos/:mso_id/companies/:company_id/job_routes" do
    it "renders a successful response" do
      create(:job_route, valid_params.merge(company: company))
      get api_v1_mso_company_job_routes_url(mso, company),
        headers: default_headers
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "GET /api/v1/msos/:mso_id/companies/:company_id/job_routes/:id" do
    it "renders a successful response" do
      job_route = create(:job_route, valid_params.merge(company: company))
      get api_v1_mso_company_job_route_url(mso, company, job_route),
        headers: default_headers
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "POST /api/v1/msos/:mso_id/companies/:company_id/job_routes" do
    context "with valid parameters" do
      it "creates a new JobRoute" do
        expect {
          post api_v1_mso_company_job_routes_url(mso, company),
            params: { job_route: valid_params },
            headers: default_headers
        }.to change(JobRoute, :count).by(1)
      end

      it "renders a JSON response with the new job_route" do
        post api_v1_mso_company_job_routes_url(mso, company),
          params: { job_route: valid_params },
          headers: default_headers
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "does not create a new JobRoute" do
        expect {
          post api_v1_mso_company_job_routes_url(mso, company),
            params: { job_route: invalid_params },
            headers: default_headers
        }.to change(JobRoute, :count).by(0)
      end

      it "renders a JSON response with errors for the new job_route" do
        post api_v1_mso_company_job_routes_url(mso, company),
          params: { job_route: invalid_params },
          headers: default_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe "PATCH /api/v1/msos/:mso_id/companies/:company_id/job_routes/:id" do
    context "with valid parameters" do
      let(:new_params) do
        { first_name: 'Jane', last_name: 'Smith' }
      end

      it "updates the requested job_route" do
        job_route = create(:job_route, valid_params.merge(company: company))
        patch api_v1_mso_company_job_route_url(mso, company, job_route),
          params: { job_route: new_params },
          headers: default_headers
        job_route.reload
        expect(job_route.first_name).to eq('Jane')
        expect(job_route.last_name).to eq('Smith')
      end

      it "renders a JSON response with the job_route" do
        job_route = create(:job_route, valid_params.merge(company: company))
        patch api_v1_mso_company_job_route_url(mso, company, job_route),
          params: { job_route: new_params },
          headers: default_headers
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the job_route" do
        job_route = create(:job_route, valid_params.merge(company: company))
        patch api_v1_mso_company_job_route_url(mso, company, job_route),
          params: { job_route: invalid_params },
          headers: default_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe "DELETE /api/v1/msos/:mso_id/companies/:company_id/job_routes/:id" do
    it "destroys the requested job_route" do
      job_route = create(:job_route, valid_params.merge(company: company))
      expect {
        delete api_v1_mso_company_job_route_url(mso, company, job_route),
          headers: default_headers
      }.to change(JobRoute, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end