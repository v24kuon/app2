class Book < ApplicationRecord
validates :title, presence: true
validates :body, presence: true
validates :body,length: { maximum: 200 }
belongs_to :user, optional: true
  def user
    return User.find_by(id: self.user_id)
  end
end
