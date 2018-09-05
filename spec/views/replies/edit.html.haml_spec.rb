require 'rails_helper'

RSpec.describe "replies/edit", type: :view do
  before(:each) do
    @reply = assign(:reply, Reply.create!(
      :user => nil,
      :tweet => nil,
      :content => "MyText"
    ))
  end

  it "renders the edit reply form" do
    render

    assert_select "form[action=?][method=?]", reply_path(@reply), "post" do

      assert_select "input[name=?]", "reply[user_id]"

      assert_select "input[name=?]", "reply[tweet_id]"

      assert_select "textarea[name=?]", "reply[content]"
    end
  end
end
