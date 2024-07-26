require 'rails_helper'

RSpec.describe "Api::V1::Inventories", type: :request do
  include_context 'has authentication'

  let(:mso) { create(:mso) }
  let(:inventory_type) { create(:inventory_type, mso: mso) }
  let(:job_route) { create(:job_route) }
  let(:user) { create(:user) }
  let(:valid_params) do
    {
      action_status_id: 1,
      inventory_type_id: inventory_type.id,
      serial_number: Faker::Number.unique.number(digits: 10).to_s,
      date_received: Time.now,
      date_refreshed: Time.now,
      date_issued: Time.now,
      date_signed: Time.now,
      date_installed: Time.now,
      date_returned: Time.now,
      area_id: create(:area).id,
      tech_id: Faker::Number.unique.number(digits: 5).to_s,
      hhc_completed: false,
      account_number: Faker::Number.unique.number(digits: 10).to_s,
      job_route_id: job_route.id,
      user_id: user.id,
      mso_id: mso.id
    }
  end
  let(:invalid_params) do
    {
      serial_number: '',
      job_route_id: nil,
      user_id: nil
    }
  end

  describe "GET /api/v1/msos/:mso_id/inventories" do
    it "renders a successful response" do
      create(:inventory, valid_params.merge(mso: mso))
      get api_v1_mso_inventories_url(mso), headers: default_headers
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "paginates results" do
      create_list(:inventory, 15, mso: mso)
      get api_v1_mso_inventories_url(mso), params: { page: 2, per: 5 }, headers: default_headers
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['meta']['pagination']['current_page']).to eq(2)
      expect(json_response['meta']['pagination']['total_pages']).to be > 1
    end
  end

  describe "GET /api/v1/msos/:mso_id/inventories/:id" do
    it "renders a successful response" do
      inventory = create(:inventory, valid_params.merge(mso: mso))
      get api_v1_mso_inventory_url(mso, inventory), headers: default_headers
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "POST /api/v1/msos/:mso_id/inventories" do
    context "with valid parameters" do
      it "creates a new Inventory" do
        expect {
          post api_v1_mso_inventories_url(mso), params: { inventory: valid_params }, headers: default_headers
        }.to change(Inventory, :count).by(1)
      end

      it "renders a JSON response with the new inventory" do
        post api_v1_mso_inventories_url(mso), params: { inventory: valid_params }, headers: default_headers
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Inventory" do
        expect {
          post api_v1_mso_inventories_url(mso), params: { inventory: invalid_params }, headers: default_headers
        }.to change(Inventory, :count).by(0)
      end

      it "renders a JSON response with errors for the new inventory" do
        post api_v1_mso_inventories_url(mso), params: { inventory: invalid_params }, headers: default_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe "PATCH /api/v1/msos/:mso_id/inventories/:id" do
    context "with valid parameters" do
      let(:new_params) do
        { serial_number: 'Updated Serial Number', tech_id: 'Updated Tech ID' }
      end

      it "updates the requested inventory" do
        inventory = create(:inventory, valid_params.merge(mso: mso))
        patch api_v1_mso_inventory_url(mso, inventory), params: { inventory: new_params }, headers: default_headers
        inventory.reload
        expect(inventory.serial_number).to eq('Updated Serial Number')
        expect(inventory.tech_id).to eq('Updated Tech ID')
      end

      it "renders a JSON response with the inventory" do
        inventory = create(:inventory, valid_params.merge(mso: mso))
        patch api_v1_mso_inventory_url(mso, inventory), params: { inventory: new_params }, headers: default_headers
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the inventory" do
        inventory = create(:inventory, valid_params.merge(mso: mso))
        patch api_v1_mso_inventory_url(mso, inventory), params: { inventory: invalid_params }, headers: default_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe "DELETE /api/v1/msos/:mso_id/inventories/:id" do
    it "destroys the requested inventory" do
      inventory = create(:inventory, valid_params.merge(mso: mso))
      expect {
        delete api_v1_mso_inventory_url(mso, inventory), headers: default_headers
      }.to change(Inventory, :count).by(-1)
    end
  end
end