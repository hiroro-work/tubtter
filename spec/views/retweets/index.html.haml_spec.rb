require 'rails_helper'

RSpec.describe "retweets/index", type: :view do
  before(:each) do
    assign(:retweets, [
      Retweet.create!(
        :user => nil,
        :tweet => nil
      ),
      Retweet.create!(
        :user => nil,
        :tweet => nil
      )
    ])
  end

  it "renders a list of retweets" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
