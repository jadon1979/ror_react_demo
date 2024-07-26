class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  belongs_to :state

  enum status: {
    disabled: 0,
    enabled: 1,
    pending_approval: 2
  }

  enum role: {
    standard_user: 0,
    admin: 1
  }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
