require 'rails_helper'

RSpec.feature 'user#show', type: :system do
  let!(:taro) { create(:user, name: 'taro', email: 'taro@example.com') }
  let!(:jiro) { create(:user, name: 'jiro', email: 'jiro@example.com') }

  background do
    visit root_path
    click_on 'ログイン'
    fill_in 'Eメール', with: "#{taro.email}"
    fill_in 'パスワード', with: "#{taro.password}"
    click_on 'ログイン'
  end

  feature '自分のホーム画面', type: :system do
    feature 'ツイート', type: :system do
      scenario 'ツイート一覧を表示する' do
        click_on 'ツイート'
        expect(page).to have_button 'つぶやく'
      end
    end

    feature 'つぶやく', type: :system do
      background do
        click_on 'ツイート'
      end

      scenario 'つぶやく' do
        fill_in 'tweet_content', with: 'はじめまして'
        click_on 'つぶやく'
        expect(page).to have_content 'つぶやきました。'
      end
    end

    feature 'おすすめユーザー', type: :system do
      scenario 'おすすめユーザーを表示する' do
        click_on 'おすすめユーザー'
        expect(page).to have_content 'おすすめユーザー'
      end
    end
  end

  feature '他ユーザーのホーム画面', type: :system do
    background do
      click_on 'おすすめユーザー'
      page.find('a', id: "#{jiro.id}").click
    end

    feature 'ツイート', type: :system do
      scenario 'ツイート一覧を表示する' do
        click_on 'ツイート'
        expect(page).to have_no_button 'つぶやく'
      end
    end

    feature 'フォロー', type: :system do
      scenario 'フォローする' do
        click_on 'フォローする'
        expect(page).to have_content "#{jiro.name} をフォローしました。"
      end
    end

    feature 'フォロー解除', type: :system do
      background do
        click_on 'フォローする'
      end

      scenario 'フォローを解除する' do
        click_on 'フォロー解除'
        expect(page).to have_content "#{jiro.name} のフォローを解除しました。"
      end
    end
  end

  feature 'ホーム画面（自分/他ユーザー共通）', type: :system do
    feature 'リツイート', type: :system do
      scenario 'リツイート一覧を表示する' do
        click_on 'リツイート'
        expect(page).to have_content 'リツイート'
      end
    end

    feature 'リプライ', type: :system do
      scenario 'リプライ一覧を表示する' do
        click_on 'リプライ'
        expect(page).to have_content 'リプライ'
      end
    end

    feature 'フォロー中', type: :system do
      scenario 'フォロー中ユーザーを表示する' do
        click_on 'フォロー中'
        expect(page).to have_content 'フォロー中'
      end
    end

    feature 'フォロワー', type: :system do
      scenario 'フォロワーを表示する' do
        click_on 'フォロワー'
        expect(page).to have_content 'フォロワー'
      end
    end
  end
end
