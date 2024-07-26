class Api::V1::MsosController < ApplicationController
  def index
    render_json MsoSerializer, collection.all
  end

  def show
    render_json MsoSerializer, resource
  end

  def create
    mso = Mso.new(mso_params)

    if mso.save
      render json: MsoSerializer.new(mso), status: :created
    else
      render_error(mso)
    end
  end

  def update
    if resource.update(mso_params)
      render json: MsoSerializer.new(resource)
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
    @resource ||= Mso.find(params[:id])
  end

  def collection
    @collection ||= apply_scopes(Mso)
  end

  def mso_params
    params.require(:mso).permit(:id, :name, :domain)
  end
end
