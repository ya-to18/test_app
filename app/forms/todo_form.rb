class TodoForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :limit, :date
  attribute :title, :string
  attribute :content, :string
  attr_accessor :tasks_attributes

  validates :title, presence: true
  validates :content, presence: true

end