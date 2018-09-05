require 'rails_helper'

RSpec.describe "replies/new", type: :view do
  before(:each) do
    assign(:reply, Reply.new(
      :user => nil,
      :tweet => nil,
      :content => "MyText"
    ))
  end

  it "renders new reply form" do
    render

    assert_select "form[action=?][method=?]", replies_path, "post" do

      assert_select "input[name=?]", "reply[user_id]"

      assert_select "input[name=?]", "reply[tweet_id]"

      assert_select "textarea[name=?]", "reply[content]"
    end
  end
end
