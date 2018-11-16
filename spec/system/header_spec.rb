require 'rails_helper'

RSpec.feature 'header', type: :system do
  given!(:taro) { create(:user, name: 'taro', email: 'taro@example.com') }
  given!(:jiro) { create(:user, name: 'jiro', email: 'jiro@example.com') }

  background do
    login_as taro, scope: :user
    visit user_path(taro)
  end

  feature 'ホーム', type: :system do
    background do
      click_on 'おすすめユーザー'
      page.find('a', id: "#{jiro.id}").click
    end

    scenario '自分のホームに戻る' do
      click_on 'ホーム'
      expect(page).to have_button 'つぶやく'
    end
  end

  feature 'アカウント', type: :system do
    scenario 'アカウントを更新する' do
      click_on 'アカウント'
      fill_in 'パスワード', with: 'hogehoge'
      fill_in 'パスワード（確認用）', with: 'hogehoge'
      fill_in '現在のパスワード', with: "#{taro.password}"
      expect {
        click_on '更新'
      }.to change(User, :count).by(0)
      expect(page).to have_content 'アカウント情報を変更しました。'
    end
  end

  feature 'ログアウト', type: :system do
    scenario 'ログアウトする' do
      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました。'
    end
  end
end
