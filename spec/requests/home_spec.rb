require 'rails_helper'

describe 'Home', type: :request do
  describe 'GET /' do
    it 'リクエストが成功すること' do
      get root_url
      expect(response).to have_http_status(200)
    end
  end
end
