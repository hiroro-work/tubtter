require 'rails_helper'

RSpec.describe "retweets/edit", type: :view do
  before(:each) do
    @retweet = assign(:retweet, Retweet.create!(
      :user => nil,
      :tweet => nil
    ))
  end

  it "renders the edit retweet form" do
    render

    assert_select "form[action=?][method=?]", retweet_path(@retweet), "post" do

      assert_select "input[name=?]", "retweet[user_id]"

      assert_select "input[name=?]", "retweet[tweet_id]"
    end
  end
end
