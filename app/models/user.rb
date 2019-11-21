class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
  :jwt_authenticatable, :registerable,
  jwt_revocation_strategy: JwtBlacklist

  enum role: [:user, :organizer, :admin]
  has_many :attendings
  has_many :events, foreign_key: "host_id"







end
