class User < ApplicationRecord

  # Deviseのログイン認証にnameを使う
  def self.find_for_database_authentication(warden_conditions)
    where(name: warden_conditions[:name]).first
  end

  has_one_attached :profile_image

  has_many :books, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { in: 2..20 } # 一意性 2~20文字
  validates :introduction, length: { maximum: 50 } #最大50文字

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
