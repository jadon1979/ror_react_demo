class JobRouteSerializer
  include JSONAPI::Serializer

  attributes :id,
    :user,
    :area,
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
    :hhc_completed,
    :created_at,
    :updated_at

  meta do |job_route|
    {
      total_job_notes: job_route.job_route_notes.count
    }
  end
end
