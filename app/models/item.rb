class Item < ApplicationRecord
  # assoc
  belongs_to :todo

  #valid
  validates_presence_of :name
end
