class Api::V1::JobRoutesController < ApplicationController
  def index
    render_json JobRouteSerializer, collection.includes(:job_route_notes).all
  end

  def show
    render_json JobRouteSerializer, resource
  end

  def create
    job_route = resource_company.job_routes.new(job_route_params)

    if job_route.save
      render json: JobRouteSerializer.new(job_route), status: :created
    else
      render_error(job_route)
    end
  end

  def update
    if resource.update(job_route_params)
      render json: JobRouteSerializer.new(resource)
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
    @resource ||= resource_company.job_routes.find(params[:id])
  end

  def collection
    @collection ||= apply_scopes(resource_company.job_routes)
  end

  def resource_company
    @resource_company ||= resource_mso.companies.find(params[:company_id])
  end

  def resource_mso
    resource_mso ||= Mso.find(params[:mso_id])
  end

  def job_route_params
    params.require(:job_route).permit(
      :user_id,
      :area_id,
      :company_id,
      :tech_id,
      :account_number,
      :job_type,
      :first_name,
      :last_name,
      :address,
      :city,
      :zip,
      :home_phone,
      :other_phonne,
      :job_date,
      :job_number,
      :status,
      :time_frame,
      :time_started,
      :time_completed,
      :hhc_completed
    )
  end
end
