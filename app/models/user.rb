class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweet, dependent: :delete_all
  has_many :follower, dependent: :delete_all
  has_many :like
  has_many :notification, dependent: :delete_all
  validates_presence_of :name, :email, :username
end
