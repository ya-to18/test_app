class TodoForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :integer
  attribute :name, :string
  attribute :limit, :date
  attribute :title, :string
  attribute :content, :string
  attribute :tasks_attributes, array: true, default: []

  validates :name, presence: true
  validates :limit, presence: true
  validates :tasks_attributes, presence: true

  def initialize(attributes = {}, todo: nil)
  attributes[:id] = todo.id if todo.present?
  if todo.present?
    attributes[:name] = todo.name
    attributes[:limit] = todo.limit
    attributes[:tasks_attributes] = todo.tasks.map { |task| { title: task.title, content: task.content } }
  end

  super(attributes)

  @tasks = (attributes[:tasks_attributes] || []).map do |task_attributes|
    TodoForm.new(task_attributes)
  end
end

def tasks_attributes=(attributes)
  @tasks = attributes.map { |task_attributes| TodoForm.new(task_attributes) }
end

def tasks
  @tasks
end

  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      todo = Todo.create!(name: name, limit: limit)
      tasks_attributes.map do |task_attributes|
        todo.tasks.create!(task_attributes)
      end
    end
  end
end