class CreateTodoTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :todo_tasks do |t|
      t.references :todo, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
