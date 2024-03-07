class TodoForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name
  attribute :limit
  attribute :title
  attribute :content

  validates :title, presence: true
  validates :content, presence: true

end