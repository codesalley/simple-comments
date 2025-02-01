require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { create(:user) }
  let(:project) { build(:project, user: user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(project).to be_valid
    end

    it 'is not valid without a name' do
      project.name = nil
      expect(project).to_not be_valid
    end

    it 'is not valid without a description' do
      project.description = nil
      expect(project).to_not be_valid
    end

    it 'is not valid with an invalid status' do
      project.status = 'invalid_status'
      expect(project).to_not be_valid
    end

    it 'is valid with a valid status' do
      Project::STATUSES.each do |status|
        project.status = status
        expect(project).to be_valid
      end
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end

    it 'has many comments' do
      assoc = described_class.reflect_on_association(:comments)
      expect(assoc.macro).to eq :has_many
    end
  end

  describe 'dependent destroy' do
    it 'destroys associated comments when project is destroyed' do
      project.save
      create(:comment, project: project)
      expect { project.destroy }.to change { Comment.count }.by(-1)
    end
  end
end
