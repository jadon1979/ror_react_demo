class Api::V1::InventoriesController < ApplicationController
  def index
    render_json InventorySerializer, collection.all
  end

  def show
    render_json InventorySerializer, resource
  end

  def create
    inventory = resource_mso.inventories.new(inventory_params)

    if inventory.save
      render json: InventorySerializer.new(inventory), status: :created
    else
      render_error(inventory)
    end
  end

  def update
    if resource.update(inventory_params)
      render json: InventorySerializer.new(resource)
    else
      render_error(resource)
    end
  end

  def destroy
    resource.destroy
    head :no_content
  end

  private

  def resource
    @resource ||= resource_mso.inventories.find(params[:id])
  end

  def collection
    @collection ||= apply_scopes(resource_mso.inventories)
  end

  def resource_mso
    resource_mso ||= Mso.find(params[:mso_id])
  end


  def inventory_params
    params.require(:inventory).permit(
      :action_status_id,
      :inventory_type_id,
      :serial_number,
      :date_received,
      :date_refreshed,
      :date_issued,
      :date_signed,
      :date_installed,
      :date_returned,
      :area_id,
      :tech_id,
      :hhc_completed,
      :account_number,
      :job_route_id,
      :user_id,
      :area_id
    )
  end
end