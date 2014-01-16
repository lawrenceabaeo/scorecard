class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :matches
  has_many :cards
  has_many :fighters # yeah, it's weird, at some point I may want to rethink a fighter 'belonging' to an end user
end
