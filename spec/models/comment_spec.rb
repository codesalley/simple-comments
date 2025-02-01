require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:comment) { create(:comment, user: user, project: project) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
    it { should have_many(:replies).dependent(:destroy) }
    it { should belong_to(:parent).optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:project) }
  end

  describe 'scopes' do
    let!(:top_level_comment) { create(:comment, user: user, project: project) }
    let!(:reply_comment) { create(:comment, user: user, project: project, parent: top_level_comment) }

    it 'returns top level comments' do
      expect(Comment.top_level).to include(top_level_comment)
      expect(Comment.top_level).not_to include(reply_comment)
    end

    it 'returns replies' do
      expect(Comment.replies).to include(reply_comment)
      expect(Comment.replies).not_to include(top_level_comment)
    end
  end

  describe '#user_name' do
    it 'returns the name of the user' do
      expect(comment.user_name).to eq(user.name)
    end
  end

  describe '#has_replies?' do
    it 'returns true if the comment has replies' do
      create(:comment, user: user, project: project, parent: comment)
      expect(comment.has_replies?).to be true
    end

    it 'returns false if the comment does not have replies' do
      expect(comment.has_replies?).to be false
    end
  end
end
