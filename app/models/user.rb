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

end
