require 'faker'


puts "Destroying all Questions Answers"
Answer.destroy_all

puts "Destroying all Questions"
Question.destroy_all

puts "Destroying all Review Comments"
Comment.destroy_all

puts "Destroying All Reviews"
Review.destroy_all

puts "Destroying All Categories"
Category.destroy_all

puts "Destroying All Venues"
Venue.destroy_all

puts "Destroying All Users"
User.destroy_all

### Categories ###

puts "Creating Categories"
(1..5).each do
  Category.create!(
    name: Faker::Restaurant.type
  )
end
puts "Created #{Category.all.count} Categories"

### Users ###

puts "Creating Users"
sample_users = [
  { email: "user@sample.com", password: "password", username: Faker::Name.name },
  { email: "user2@sample.com", password: "password", username: Faker::Name.name },
  { email: "user3@sample.com", password: "password", username: Faker::Name.name },
  { email: "owner@sample.com", password: "password", username: Faker::Name.name, role: :owner },
  { email: "owner2@sample.com", password: "password", username: Faker::Name.name, role: :owner },
  { email: "owner3@sample.com", password: "password", username: Faker::Name.name, role: :owner },
  { email: "moderator@sample.com", password: "password", username: Faker::Name.name, role: :moderator },
  { email: "admin@sample.com", password: "password", username: "Admin", role: :admin }
]


User.create!(sample_users)
puts "Created #{User.admin.all.count} Admin, #{User.moderator.all.count} Moderator, #{User.owner.all.count} Owners, and #{User.reviewer.all.count} Plain Users"

### Venues ###

(1..40).each do
  Venue.create!(
    name: Faker::Restaurant.name,
    is_active: [ true, false ].sample,
    user_id: User.where(role: :owner).sample.id,
    categories: Category.all.sample(rand(1..3))
  )
end

puts "Created #{Venue.all.count} Venues"

### Reviews ###

puts "Creating Reviews"
reviews = []
(1..60).each do
  reviews << {
    title: Faker::Restaurant.name,
    content: Faker::Restaurant.review,
    venue_id: Venue.all.sample.id,
    user_id: User.where(role: :reviewer).sample.id
}
end

reviews.each do |review_data|
  review= Review.create!(review_data)
  Rating.create!(
    review: review,
    atmosphere_rating: rand(1..6),
    availability_rating: rand(1..6),
    quality_rating: rand(1..6),
    service_rating: rand(1..6),
    uniqueness_rating: rand(1..6),
    value_rating: rand(1..6)
  )
end
puts "Created #{Review.all.count} Reviews"

### Review Comments ###

puts "Creating Review Comments"
comments = []
(1..20).each do
  comments << {
    content: Faker::Restaurant.review[1..254],
    review_id: Review.all.sample.id,
    user_id: User.all.sample.id
}
end

comments.each do |review_comment_data|
  Comment.create!(review_comment_data)
end
puts "Created #{Comment.all.count} Review Comments"

### Venue Questions ###

puts "Creating Venue Questions"
questions = []
(1..20).each do
  questions << {
    question: Faker::Restaurant.review[1..254],
    venue_id: Venue.all.sample.id,
    user_id: User.all.sample.id
}
end

questions.each do |venue_question_data|
  Question.create!(venue_question_data)
end
puts "Created #{Question.all.count} Venue Questions"

### Venue Question Answers ###

puts "Creating Question Answers"
answers = []
(1..40).each do
  answers << {
    content: Faker::Restaurant.review[1..499],
    question_id: Question.all.sample.id,
    user_id: User.all.sample.id
}
end
answers.each do |question_answer_data|
  Answer.create!(question_answer_data)
end
puts "Created #{Answer.all.count} Venue Question Answers"

puts "Seeding Completed"
