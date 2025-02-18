class User < ApplicationRecord

  # Deviseのログイン認証にnameを使う
  def self.find_for_database_authentication(warden_conditions)
    where(name: warden_conditions[:name]).first
  end

  has_one_attached :image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
