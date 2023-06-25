class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  def manager?
    has_role?(:manager)
  end

  def team_lead?
    has_role?(:team_lead)
  end

  def member?
    has_role?(:member)
  end
end
