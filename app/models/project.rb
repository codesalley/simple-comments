class Project < ApplicationRecord
  STATUSES = %w[active inactive archived completed pending]

  validates :name, :description, presence: true
  validates :status, inclusion: { in: STATUSES }, allow_nil: false


  belongs_to :user

  has_many :comments, dependent: :destroy
end
