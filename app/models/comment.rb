class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :project

    validates :content, presence: true
    validates :user, presence: true
    validates :project, presence: true


    has_many :replies, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy
    belongs_to :parent, class_name: "Comment", optional: true
    scope :top_level, -> { where(parent_id: nil) }
    scope :replies, -> { where.not(parent_id: nil) }

    def user_name
      user.name
    end

    def has_replies?
      replies.any?
    end
end
