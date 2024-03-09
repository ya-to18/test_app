class TodoTask < ApplicationRecord
  belongs_to :todo
  belongs_to :task
end