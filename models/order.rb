class Order < ApplicationRecord
  has_many :orderitems
  belongs_to :user
end
