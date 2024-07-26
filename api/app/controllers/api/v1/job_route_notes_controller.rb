class Api::V1::JobRouteNotesController < ApplicationController
  def index
    render_json JobRouteNoteSerializer, collection.all
  end

  def show
    render_json JobRouteNoteSerializer, resource
  end

  def create
    job_route_note = resource_job_route.job_route_notes.new(job_route_note_params.merge(user_id: current_user.id))

    if job_route_note.save
      render json: JobRouteNoteSerializer.new(job_route_note), status: :created
    else
      render_error(job_route_note)
    end
  end

  def update
    if resource.update(job_route_note_params)
      render json: JobRouteNoteSerializer.new(resource)
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
    @resource ||= resource_job_route.job_route_notes.find(params[:id])
  end

  def collection
    @collection ||= apply_scopes(resource_job_route.job_route_notes.includes(:user))
  end

  def resource_job_route
    @resource_job_route ||= resource_company.job_routes.find(params[:job_route_id])
  end

  def resource_company
    @resource_company ||= resource_mso.companies.find(params[:company_id])
  end

  def resource_mso
    resource_mso ||= Mso.find(params[:mso_id])
  end

  def job_route_note_params
    params.require(:job_route_note).permit(:user_id, :job_route_id, :note)
  end
end
