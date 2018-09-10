require 'rails_helper'

RSpec.describe "retweets/show", type: :view do
  before(:each) do
    @retweet = assign(:retweet, Retweet.create!(
      :user => nil,
      :tweet => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
