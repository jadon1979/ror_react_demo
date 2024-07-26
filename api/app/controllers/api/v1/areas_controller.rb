class Api::V1::AreasController < ApplicationController
  def index
    render_json AreaSerializer, collection.all
  end

  def show
    render_json AreaSerializer, resource
  end

  def create
    area = resource_mso.areas.new(area_params)

    if area.save
      render json: AreaSerializer.new(area), status: :created
    else
      render_error(area)
    end
  end

  def update
    if resource.update(area_params)
      render json: AreaSerializer.new(resource)
    else
      render_error(resource)
    end
  end

  def destroy
    resource.destroy
    head :no_content
  end

  private

  def collection
    @collection ||= apply_scopes(resource_mso.areas)
  end

  def resource
    @resource ||= resource_mso.areas.find(params[:id])
  end

  def resource_mso
    resource_mso ||= Mso.find(params[:mso_id])
  end


  def area_params
    params.require(:area).permit(
      :mso_id,
      :name,
      :address_1,
      :address_2,
      :city,
      :state_id,
      :zip
    )
  end
end