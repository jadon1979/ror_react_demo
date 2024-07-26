class Api::V1::InventoryTypesController < ApplicationController
  def index
    render_json InventoryTypeSerializer, collection.all
  end

  def show
    render_json InventoryTypeSerializer, resource
  end

  def create
    inventory_type = resource_mso.inventory_types.new(inventory_type_params)

    if inventory_type.save
      render json: InventoryTypeSerializer.new(inventory_type), status: :created
    else
      render_error(inventory_type)
    end
  end

  def update
    if resource.update(inventory_type_params)
      render json: InventoryTypeSerializer.new(resource)
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
    @resource ||= resource_mso.inventory_types.find(params[:id])
  end

  def collection
    @collection ||= apply_scopes(resource_mso.inventory_types)
  end

  def resource_mso
    resource_mso ||= Mso.find(params[:mso_id])
  end

  def inventory_type_params
    params.require(:inventory_type).permit(:name, :mso_id, :price)
  end
end