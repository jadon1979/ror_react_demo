require 'rails_helper'

RSpec.describe JobRouteNote, type: :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:job_route_id) }
  it { should validate_presence_of(:note) }
end
