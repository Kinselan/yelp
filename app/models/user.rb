class User < ActiveRecord::Base
  has_secure_password validations: false # todo why validations: false?
  has_many :reviews
  validates_presence_of :email, :name
  validates_uniqueness_of :email
end
