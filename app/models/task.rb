class Task < ApplicationRecord
  belongs_to :user, optional: true

  validates :title, :description, presence: true
end
