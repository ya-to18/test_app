class Todo < ApplicationRecord
  has_many :todo_tasks
  has_many :tasks, through: :todo_tasks
end
