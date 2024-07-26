class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?

  has_scope :page, default: 1
  has_scope :per do |controller, scope, value|
    scope.page(controller.params[:page] || 1).per(value)
  end

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def render_json(serializer, obj, options={})
    if params[:id].blank? && obj != current_user
      return render_collection(serializer, obj, options)
    end

    render json: serializer.new(obj, options)
  end

  def render_error(resource)
    render json: {
      errors: resource.errors.map do |err|
        {
          status: '422',
          source: { pointer: "/data/attributes/#{err.attribute}" },
          title: 'Invalid Attribute',
          detail: err.message
        }
      end
    }, status: :unprocessable_entity
  end

  protected

  def render_collection(serializer, collection, options={})
    options = meta_pagination(collection, options)
    render json: serializer.new(collection, options)
  end

  def meta_pagination(paginated_obj, options={})
    options[:meta] = {} unless options.has_key?(:meta)
    meta_options = options[:meta].merge(generate_pagination(paginated_obj))
    options[:meta] = meta_options
    options
  end

  def generate_pagination(obj)
    {
      pagination: {
        current_page: obj.current_page,
        prev_page: obj.prev_page,
        next_page: obj.next_page,
        total_pages: obj.total_pages,
        total_items: obj.total_count
      }
    }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :first_name,
      :last_name,
      :email
    ])
  end

  private

  def not_found
    render json: {
      'errors': [ { 'status': '404', 'title': 'Not Found' } ]
    }, status: 404
  end
end
