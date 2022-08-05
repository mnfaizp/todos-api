class Todo < ApplicationRecord
    # assoc
    has_many :items, dependent: :destroy

    # validate
    validates_presence_of :title, :created_by
end
