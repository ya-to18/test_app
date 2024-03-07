class Task < ApplicationRecord
  has_many :todo_tasks, dependent: :destroy
  has_many :todos, through: :todo_tasks

  validates :title, presence: true
  validates :content, presence: true
end
