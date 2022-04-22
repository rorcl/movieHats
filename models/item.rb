class Item < ApplicationRecord

    validates_presence_of :title, :message => 'Title'
    validates :title, length: {minimum: 5}

    validates_presence_of :description, :message => 'Description'
    validates :description, length: {minimum: 10}

    validates_presence_of :price, :message => 'Price'
    validates :price, length: {minimum: 2}

    validates_presence_of :category, :message => 'Category'
    validates :category, length: {minimum: 3}

    validates_presence_of :brand, :message => 'Brand'
    validates :brand, length: {minimum: 3}

end
