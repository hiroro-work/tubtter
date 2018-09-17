require 'rails_helper'

RSpec.feature 'Devises', type: :system do
  given(:user) { create(:user, name: 'taro', email: 'taro@example.com') }

  feature 'アカウント登録', type: :system do
    background do
      visit root_path
      click_on 'アカウント作成'
      fill_in 'Eメール', with: 'jiro@example.com'
      fill_in 'パスワード', with: 'hogehoge'
      fill_in 'パスワード（確認用）', with: 'hogehoge'
    end

    scenario '名前未入力はNG' do
      click_on 'アカウント登録'
      expect(page).to have_content '名前を入力してください'
    end

    scenario '使用済みの名前はNG' do
      fill_in '名前', with: "#{user.name}"
      click_on 'アカウント登録'
      expect(page).to have_content '名前はすでに存在します'
    end

    scenario 'アカウント登録OK' do
      fill_in '名前', with: 'jiro'
      click_on 'アカウント登録'
      expect(page).to have_content 'アカウント登録が完了しました。'
    end
  end

  feature 'アカウント更新/削除', type: :system do
    background do
      visit root_path
      click_on 'ログイン'
      fill_in 'Eメール', with: "#{user.email}"
      fill_in 'パスワード', with: "#{user.password}"
      click_on 'ログイン'
    end

    scenario 'アカウント更新OK' do
      click_on 'アカウント'
      fill_in 'パスワード', with: 'hogehoge'
      fill_in 'パスワード（確認用）', with: 'hogehoge'
      fill_in '現在のパスワード', with: "#{user.password}"
      click_on '更新'
      expect(page).to have_content 'アカウント情報を変更しました。'
    end

    scenario 'アカウント削除OK', js: true do
      click_on 'アカウント削除'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
    end
  end

  feature 'ログイン', type: :system do
    scenario 'ログインOK' do
      visit root_path
      click_on 'ログイン'
      fill_in 'Eメール', with: "#{user.email}"
      fill_in 'パスワード', with: "#{user.password}"
      click_on 'ログイン'
      expect(page).to have_content 'ログインしました。'
    end
  end
end
