class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, :sure_name, presence: true

  after_create :update_auth_token

  private
  def update_auth_token
    update(auth_token: JsonWebToken.encode(user: { id: id }))
  end
end
