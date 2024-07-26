class Api::V1::UsersController < ApplicationController

  def index
    render_json UserSerializer, User.all
  end

  def me
    render_json UserSerializer, current_user
  end
end
