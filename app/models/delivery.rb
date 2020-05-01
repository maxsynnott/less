class Delivery < ApplicationRecord
  belongs_to :user
  belongs_to :address

  has_many :orders

  validates_presence_of :user
end
