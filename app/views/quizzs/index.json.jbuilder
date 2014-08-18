json.array!(@quizzs) do |quizz|
  json.extract! quizz, :id, :question, :ans1, :ans2, :ans3, :ans4, :correctans
  json.url quizz_url(quizz, format: :json)
end
