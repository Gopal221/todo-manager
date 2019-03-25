class TodoList < ApplicationRecord
	belongs_to :user
 	has_many :todo_items , -> { order(position: :asc) }
 	validates :title, presence: true
end
