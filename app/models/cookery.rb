class Cookery < ApplicationRecord

  belongs_to :recipe

  validates :process, presence: true

end
