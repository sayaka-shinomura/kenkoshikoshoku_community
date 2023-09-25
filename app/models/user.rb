class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #0が男性、1が女性
  enum gender: { man: "0", woman: "1" }

  validates :account_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :telephone_number, presence: true, format: { with: /\A\d{10,11}\z/ }
  validates :birth_date, presence: true
  validates :gender, presence: true


  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.account_name = "ゲスト"
      user.telephone_number = "09012345678"
      user.birth_date = "19900101"
      user.gender = "1"
    end
  end


end
