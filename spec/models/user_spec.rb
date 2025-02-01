require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(email: "test@example.com", password: "password")
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user = User.new(email: nil, password: "password")
    expect(user).to_not be_valid
  end

  it "is not valid without a password" do
    user = User.new(email: "test@example.com", password: nil)
    expect(user).to_not be_valid
  end

  it "has many projects" do
    assoc = User.reflect_on_association(:projects)
    expect(assoc.macro).to eq :has_many
  end

  it "has many comments" do
    assoc = User.reflect_on_association(:comments)
    expect(assoc.macro).to eq :has_many
  end

  it "destroys associated comments when user is destroyed" do
    user = User.create(email: "test@example.com", password: "password")
    project = user.projects.create!(name: "Test project", description: "This is a project.", status: "active")
    user.comments.create!(content: "Test comment", project: project)
    expect { user.destroy }.to change { Comment.count }.by(-1)
  end
end
