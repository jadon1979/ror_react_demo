class Api::V1::CompaniesController < ApplicationController
  def index
    render_json CompanySerializer, collection.all
  end

  def show
    render_json CompanySerializer, resource
  end

  def create
    company = resource_mso.companies.new(company_params)

    if company.save
      render json: CompanySerializer.new(company), status: :created
    else
      render_error(company)
    end
  end

  def update
    if resource.update(company_params)
      render json: CompanySerializer.new(resource)
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
    @resource ||= resource_mso.companies.find(params[:id])
  end

  def collection
    @collection ||= apply_scopes(resource_mso.companies)
  end

  def resource_mso
    resource_mso ||= Mso.find(params[:mso_id])
  end

  def company_params
    params.require(:company).permit(
      :name,
      :mso,
      :phone_number,
      :address_1,
      :address_2,
      :city,
      :zip,
      :state
    )
  end
end