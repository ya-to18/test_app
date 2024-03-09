class TodoForm
  include ActiveModel::Model
  include Virtus.model

  attribute :name, String
  attribute :limit, Date
  # attribute :title, :string
  # attribute :content, :string
  attr_accessor :tasks

  # validates :title, presence: true
  # validates :content, presence: true
  validates :name, presence: true
  validates :limit, presence: true
  validates :tasks_attributes, presence: true

  def initialize(todo = Todo.new)
    @todo = todo
    self.attributes = @todo.attributes if @todo.persisted?
  end

  def assign_attributes(params = {})
    @params = params
    tasks_attributes = params[:tasks_attributes]

    @tasks ||= []
    tasks_attributes&.map do |tasks_attributes|
      task = Task.new(tasks_attributes)
      @tasks.push(task)
    end

    @params.delete(:tasks_attributes)
    @todo.assign_attributes(@params) if @todo.persisted?

    super(@params)
    binding.pry
  end

  def save
    binding.pry
    # return false if invalid?

    if @todo.persisted?
      @todo.tasks = tasks if tasks.present?
      @todo.save!
    else
      todo = Todo.new(name: name, limit: limit)
      todo.tasks = tasks if tasks.present?
      todo.save!
    end
  end
end