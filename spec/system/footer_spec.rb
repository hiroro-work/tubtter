require 'rails_helper'

RSpec.feature 'footer', type: :system do
  given(:taro) { create(:user, name: 'taro', email: 'taro@example.com') }

  background do
    visit root_path
    click_on 'ログイン'
    fill_in 'Eメール', with: "#{taro.email}"
    fill_in 'パスワード', with: "#{taro.password}"
    click_on 'ログイン'
  end

  context 'アカウント削除' do
    scenario 'アカウントを削除する', js: true do
      click_on 'アカウント削除'
      page.find('.modal-content')
      click_on '削除'
      expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
    end
  end
end
