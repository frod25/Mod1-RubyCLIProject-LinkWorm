require 'faker'

Link.destroy_all
User.destroy_all
UserLink.destroy_all

felix = User.create(user_name: "Felix", password: "123")

10.times do
    new_user = User.create(user_name: Faker::Internet.username, password: "123", email: Faker::Internet.email)
    puts new_user.user_name
    Link.create(url: Faker::Internet.url, title: Faker::Book.title, category: Faker::Book.genre , short_desc: Faker::ChuckNorris.fact, is_private: false)
    UserLink.create(user_id: User.all.sample.id, link_id: Link.all.sample.id, visited: false, is_favorite: false)
end

puts "Seeded..."