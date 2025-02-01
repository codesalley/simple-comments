# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'Seeding the database...'

['user@user.com', 'admin@admin.com'].each do |email|
  name = email.split('@').first.capitalize
  User.find_or_initialize_by(email: email) do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
    user.name = name
    user.save!
  end
end

['Project A', 'Project B', 'Project C'].each do |project_name|
  random_user = User.take(2).sample
  random_status = Project::STATUSES.sample
  Project.find_or_create_by!(name: project_name, description: 'This is a project.', status: random_status, user: random_user)
end


puts 'Seeding complete!'
