require 'rails_helper'

RSpec.feature 'user#show', type: :system do
  given!(:taro) { create(:user, name: 'taro', email: 'taro@example.com') }
  given!(:jiro) { create(:user, name: 'jiro', email: 'jiro@example.com') }

  background do
    login_as taro, scope: :user
    visit user_path(taro)
  end

  context '自分のホーム画面' do
    context 'ツイート' do
      scenario 'ツイート一覧を表示する' do
        click_on 'ツイート'
        expect(page).to have_button 'つぶやく'
      end
    end

    context 'つぶやく' do
      background do
        click_on 'ツイート'
      end

      scenario 'content未入力だとつぶやけない' do
        click_on 'つぶやく'
        expect(page).to have_no_content 'つぶやきました。'
      end

      scenario 'つぶやく' do
        fill_in 'tweet_content', with: 'はじめまして'
        click_on 'つぶやく'
        expect(page).to have_content 'つぶやきました。'
      end
    end

    context 'おすすめユーザー' do
      scenario 'おすすめユーザーを表示する' do
        click_on 'おすすめユーザー'
        expect(page).to have_content 'おすすめユーザー'
      end
    end
  end

  context '他ユーザーのホーム画面' do
    background do
      click_on 'おすすめユーザー'
      page.find('a', id: "#{jiro.id}").click
    end

    context 'ツイート' do
      scenario 'ツイート一覧を表示する' do
        click_on 'ツイート'
        expect(page).to have_no_button 'つぶやく'
      end
    end

    context 'フォロー' do
      scenario 'フォローする' do
        click_on 'フォローする'
        expect(page).to have_content "#{jiro.name} をフォローしました。"
      end
    end

    context 'フォロー解除' do
      background do
        click_on 'フォローする'
      end

      scenario 'フォローを解除する' do
        click_on 'フォロー解除'
        expect(page).to have_content "#{jiro.name} のフォローを解除しました。"
      end
    end
  end

  context 'ホーム画面（自分/他ユーザー共通）' do
    context 'リツイート' do
      scenario 'リツイート一覧を表示する' do
        click_on 'リツイート'
        expect(page).to have_content 'リツイート'
      end
    end

    context 'リプライ' do
      scenario 'リプライ一覧を表示する' do
        click_on 'リプライ'
        expect(page).to have_content 'リプライ'
      end
    end

    context 'フォロー中' do
      scenario 'フォロー中ユーザーを表示する' do
        click_on 'フォロー中'
        expect(page).to have_content 'フォロー中'
      end
    end

    context 'フォロワー' do
      scenario 'フォロワーを表示する' do
        click_on 'フォロワー'
        expect(page).to have_content 'フォロワー'
      end
    end
  end
end
