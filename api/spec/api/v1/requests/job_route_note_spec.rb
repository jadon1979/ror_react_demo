require 'rails_helper'

RSpec.describe "Api::V1::JobRouteNote", type: :request do
  include_context 'has authentication'

  let(:mso) { create(:mso) }
  let(:company) { create(:company, mso: mso) }
  let(:job_route) { create(:job_route, company: company) }

  let(:valid_params) do
    {
      user_id: default_user.id,
      job_route_id: job_route.id,
      note: 'This is a note'
    }
  end
  let(:invalid_params) do
    {
      user_id: default_user.id,
      job_route_id: job_route.id,
      note: ''
    }
  end

  describe "GET /api/v1/msos/:mso_id/companies/:company_id/job_routes/:job_route_id/job_route_notes" do
    it "renders a successful response" do
      create(:job_route_note, valid_params.merge(job_route: job_route, user: default_user))
      get api_v1_mso_company_job_route_job_route_notes_url(mso, company, job_route),
        headers: default_headers
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "GET /api/v1/msos/:mso_id/companies/:company_id/job_routes/:job_route_id/job_route_notes/:id" do
    it "renders a successful response" do
      job_route_note = create(:job_route_note, valid_params.merge(job_route: job_route, user: default_user))
      get api_v1_mso_company_job_route_job_route_note_url(mso, company, job_route, job_route_note),
        headers: default_headers
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "POST /api/v1/msos/:mso_id/companies/:company_id/job_routes/:job_route_id/job_route_notes" do
    context "with valid parameters" do
      it "creates a new JobRouteNote" do
        expect {
          post api_v1_mso_company_job_route_job_route_notes_url(mso, company, job_route),
            params: { job_route_note: valid_params },
            headers: default_headers
        }.to change(JobRouteNote, :count).by(1)
      end

      it "renders a JSON response with the new job_route_note" do
        post api_v1_mso_company_job_route_job_route_notes_url(mso, company, job_route),
          params: { job_route_note: valid_params },
          headers: default_headers
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "does not create a new JobRouteNote" do
        expect {
          post api_v1_mso_company_job_route_job_route_notes_url(mso, company, job_route),
            params: { job_route_note: invalid_params },
            headers: default_headers
        }.to change(JobRouteNote, :count).by(0)
      end

      it "renders a JSON response with errors for the new job_route_note" do
        post api_v1_mso_company_job_route_job_route_notes_url(mso, company, job_route),
          params: { job_route_note: invalid_params },
          headers: default_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe "PATCH /api/v1/msos/:mso_id/companies/:company_id/job_routes/:job_route_id/job_route_notes/:id" do
    context "with valid parameters" do
      let(:new_params) do
        { note: 'Updated note' }
      end

      it "updates the requested job_route_note" do
        job_route_note = create(:job_route_note, valid_params.merge(job_route: job_route, user: default_user))
        patch api_v1_mso_company_job_route_job_route_note_url(mso, company, job_route, job_route_note),
          params: { job_route_note: new_params },
          headers: default_headers
        job_route_note.reload
        expect(job_route_note.note).to eq('Updated note')
      end

      it "renders a JSON response with the job_route_note" do
        job_route_note = create(:job_route_note, valid_params.merge(job_route: job_route, user: default_user))
        patch api_v1_mso_company_job_route_job_route_note_url(mso, company, job_route, job_route_note),
          params: { job_route_note: new_params },
          headers: default_headers
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the job_route_note" do
        job_route_note = create(:job_route_note, valid_params.merge(job_route: job_route, user: default_user))
        patch api_v1_mso_company_job_route_job_route_note_url(mso, company, job_route, job_route_note), params: { job_route_note: invalid_params },
          headers: default_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe "DELETE /api/v1/msos/:mso_id/companies/:company_id/job_routes/:job_route_id/job_route_notes/:id" do
    it "destroys the requested job_route_note" do
      job_route_note = create(:job_route_note, valid_params.merge(job_route: job_route, user: default_user))
      expect {
        delete api_v1_mso_company_job_route_job_route_note_url(mso, company, job_route, job_route_note),
          headers: default_headers
      }.to change(JobRouteNote, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end