class TagRelation < ApplicationRecord
  belongs_to :recipe
  belongs_to :tag
end
