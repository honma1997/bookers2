class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true # 空でない設定
  validates :body, presence: true, length: { maximum: 200 } # 空でなく最大200文字

end
