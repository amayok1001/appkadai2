class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :books, dependent: :destroy

  # プロフィール画像用
  attachment :profile_image

  #usenameを必須・一意とする
  validates_uniqueness_of :name
  validates_presence_of :name
  validates :name, length: { minimum: 2, maximum: 20 }
  validates :intro, length: { maximum: 50 }

   # usernameを利用してログインするようにオーバーライド
   def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      # 認証の条件式を変更する
      where(conditions).where(["username = :value", { :value => username }]).first
    else
      where(conditions).first
    end
  end
end
