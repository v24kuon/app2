class User < ApplicationRecord
validates :name, presence: true
validates :name,length: { minimum: 2, maximum: 20 }
validates :introduction,length: { maximum: 50 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  attachment :profile_image
  def books
    return Book.where(user_id: self.id)
  end
end
