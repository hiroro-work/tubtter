require 'rails_helper'

RSpec.feature 'home#index', type: :system do
  let(:taro) { create(:user, name: 'taro', email: 'taro@example.com') }

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
      fill_in '名前', with: "#{taro.name}"
      click_on 'アカウント登録'
      expect(page).to have_content '名前はすでに存在します'
    end

    scenario 'アカウントを登録する' do
      fill_in '名前', with: 'jiro'
      click_on 'アカウント登録'
      expect(page).to have_content 'アカウント登録が完了しました。'
    end
  end


  feature 'ログイン', type: :system do
    scenario 'ログインする' do
      visit root_path
      click_on 'ログイン'
      fill_in 'Eメール', with: "#{taro.email}"
      fill_in 'パスワード', with: "#{taro.password}"
      click_on 'ログイン'
      expect(page).to have_content 'ログインしました。'
    end
  end
end
