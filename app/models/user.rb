class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :profiles

  def self.get_current_profile(id)
    id = find(id).profiles[0].id
    return Profile.find(id)
  end
end
