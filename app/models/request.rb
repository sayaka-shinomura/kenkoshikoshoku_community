class Request < ApplicationRecord
  belongs_to :user

  validates :content, presence: true


  def self.search(search)
    if search != ""
      Request.joins(:user)
      .where(["users.account_name LIKE(?) OR content LIKE(?)",
      "%#{search}%", "%#{search}%"])
    else
      Request.all
    end
  end
end
