require 'rails_helper'

RSpec.feature 'footer', type: :system do
  given(:taro) { create(:user, name: 'taro', email: 'taro@example.com') }

  background do
    login_as taro, scope: :user
    visit user_path(taro)
  end

  feature 'アカウント削除', type: :system do
    scenario 'アカウントを削除する', js: true do
      click_on 'アカウント削除'
      page.find('.modal-content')
      expect {
        click_on '削除'
      }.to change(User, :count).by(-1)
      expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
    end
  end
end
