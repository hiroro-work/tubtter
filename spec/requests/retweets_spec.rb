require 'rails_helper'

RSpec.describe "Retweets", type: :request do
  describe "GET /retweets" do
    it "works! (now write some real specs)" do
      get retweets_path
      expect(response).to have_http_status(200)
    end
  end
end
