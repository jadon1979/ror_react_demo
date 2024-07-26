require 'rails_helper'

RSpec.describe "Api::V1::Msos", type: :request do
  include_context 'has authentication'

  let(:valid_params) {{ name: 'ABC MSO', domain: 'abcmso' }}
  let(:invalid_params) {{ name: '', domain: '' }}

  describe "GET /index" do
    it "renders a successful response" do
      Mso.create! valid_params
      get api_v1_msos_url, headers: default_headers
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      mso = Mso.create! valid_params
      get api_v1_msos_url(mso), headers: default_headers
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new MSO" do
        expect {
          post api_v1_msos_url,
            params: { mso: valid_params },
            headers: default_headers
        }.to change(Mso, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new MSO" do
        expect {
          post api_v1_msos_url,
            params: { mso: invalid_params },
            headers: default_headers
        }.to change(Mso, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_params) {
        { name: 'Updated MSO', domain: 'updatedmso' }
      }

      it "updates the requested MSO" do
        mso = Mso.create! valid_params
        patch api_v1_mso_url(mso),
          params: { mso: new_params },
          headers: default_headers
        mso.reload
        expect(mso.name).to eq('Updated MSO')
        expect(mso.domain).to eq('updatedmso')
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested post" do
      mso = Mso.create! valid_params
      expect {
        delete api_v1_mso_url(mso), headers: default_headers
      }.to change(Mso, :count).by(-1)
    end
  end
end
