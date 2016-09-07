namespace :db do
  task rake_role: :environment do
    puts "Update Roles Data"

    Role.first.update_attributes role_type: Role.role_types[:admin]
    Role.second.update_attributes role_type: Role.role_types[:trainer]
    Role.third.update_attributes role_type: Role.role_types[:trainee]


    puts "Create User Roles"
    User.first.user_roles.create! role_id: 1
    User.second.user_roles.create! role_id: 2

    User.offset(2).each do |user|
      user.user_roles.create! role_id: 3
    end
  end
end
