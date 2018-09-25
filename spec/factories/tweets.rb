FactoryBot.define do
  factory :tweet do
    user nil
    parent_tweet nil
    content "MyText"
  end
end
