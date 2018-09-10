require 'rails_helper'

RSpec.describe "retweets/new", type: :view do
  before(:each) do
    assign(:retweet, Retweet.new(
      :user => nil,
      :tweet => nil
    ))
  end

  it "renders new retweet form" do
    render

    assert_select "form[action=?][method=?]", retweets_path, "post" do

      assert_select "input[name=?]", "retweet[user_id]"

      assert_select "input[name=?]", "retweet[tweet_id]"
    end
  end
end
