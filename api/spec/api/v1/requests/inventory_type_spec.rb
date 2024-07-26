require 'rails_helper'

RSpec.describe "Api::V1::InventoryTypes", type: :request do
  include_context 'has authentication'

  let(:mso) { create(:mso) }
  let(:valid_params) do
    {
      name: Faker::Commerce.product_name,
      price: Faker::Commerce.price(range: 0..100.0, as_string: false)
    }
  end
  let(:invalid_params) do
    {
      name: '',
      price: nil
    }
  end

  describe "GET /api/v1/msos/:mso_id/inventory_types" do
    it "renders a successful response" do
      create(:inventory_type, valid_params.merge(mso: mso))
      get api_v1_mso_inventory_types_url(mso), headers: default_headers
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "paginates results" do
      create_list(:inventory_type, 15, mso: mso)
      get api_v1_mso_inventory_types_url(mso), params: { page: 2, per: 5 }, headers: default_headers
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response['meta']['pagination']['current_page']).to eq(2)
      expect(json_response['meta']['pagination']['total_pages']).to be > 1
    end
  end

  describe "GET /api/v1/msos/:mso_id/inventory_types/:id" do
    it "renders a successful response" do
      inventory_type = create(:inventory_type, valid_params.merge(mso: mso))
      get api_v1_mso_inventory_type_url(mso, inventory_type), headers: default_headers
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "POST /api/v1/msos/:mso_id/inventory_types" do
    context "with valid parameters" do
      it "creates a new InventoryType" do
        expect {
          post api_v1_mso_inventory_types_url(mso), params: { inventory_type: valid_params }, headers: default_headers
        }.to change(InventoryType, :count).by(1)
      end

      it "renders a JSON response with the new inventory_type" do
        post api_v1_mso_inventory_types_url(mso), params: { inventory_type: valid_params }, headers: default_headers
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "does not create a new InventoryType" do
        expect {
          post api_v1_mso_inventory_types_url(mso), params: { inventory_type: invalid_params }, headers: default_headers
        }.to change(InventoryType, :count).by(0)
      end

      it "renders a JSON response with errors for the new inventory_type" do
        post api_v1_mso_inventory_types_url(mso), params: { inventory_type: invalid_params }, headers: default_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe "PATCH /api/v1/msos/:mso_id/inventory_types/:id" do
    context "with valid parameters" do
      let(:new_params) do
        { name: 'Updated Inventory Type', price: 45.99 }
      end

      it "updates the requested inventory_type" do
        inventory_type = create(:inventory_type, valid_params.merge(mso: mso))
        patch api_v1_mso_inventory_type_url(mso, inventory_type), params: { inventory_type: new_params }, headers: default_headers
        inventory_type.reload
        expect(inventory_type.name).to eq('Updated Inventory Type')
        expect(inventory_type.price).to eq(45.99)
      end

      it "renders a JSON response with the inventory_type" do
        inventory_type = create(:inventory_type, valid_params.merge(mso: mso))
        patch api_v1_mso_inventory_type_url(mso, inventory_type), params: { inventory_type: new_params }, headers: default_headers
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the inventory_type" do
        inventory_type = create(:inventory_type, valid_params.merge(mso: mso))
        patch api_v1_mso_inventory_type_url(mso, inventory_type), params: { inventory_type: invalid_params }, headers: default_headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end
  end

  describe "DELETE /api/v1/msos/:mso_id/inventory_types/:id" do
    it "destroys the requested inventory_type" do
      inventory_type = create(:inventory_type, valid_params.merge(mso: mso))
      expect {
        delete api_v1_mso_inventory_type_url(mso, inventory_type), headers: default_headers
      }.to change(InventoryType, :count).by(-1)
    end
  end
end