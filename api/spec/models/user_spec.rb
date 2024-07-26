# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do

  subject { build(:user)}

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:phone_number) }

  # Enums
  it { should define_enum_for(:status).with_values([
      :disabled,
      :enabled,
      :pending_approval
    ])
  }
  it { should define_enum_for(:role).with_values([
      :standard_user,
      :admin
    ])
  }

  describe "#full_name" do
    it "returns the full name" do
      expect(subject.full_name).to eq("#{subject.first_name} #{subject.last_name}")
    end
  end
end