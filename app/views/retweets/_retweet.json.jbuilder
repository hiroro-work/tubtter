json.extract! retweet, :id, :user_id, :tweet_id, :created_at, :updated_at
json.url retweet_url(retweet, format: :json)
