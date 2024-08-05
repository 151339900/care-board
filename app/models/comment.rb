class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  default_scope { joins(:user).where(user: {is_active: true}) }
end
