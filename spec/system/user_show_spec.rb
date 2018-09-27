require 'rails_helper'

RSpec.feature 'user#show', type: :system do
  given!(:taro) { create(:user, name: 'taro', email: 'taro@example.com') }
  given!(:jiro) { create(:user, name: 'jiro', email: 'jiro@example.com') }

  background do
    login_as taro, scope: :user
    visit user_path(taro)
  end

  context '自分のホーム画面' do
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

      scenario 'content未入力だとつぶやけない' do
        expect {
          click_on 'つぶやく'
        }.to change(Tweet, :count).by(0)
        expect(page).to have_no_content 'つぶやきました。'
      end

      scenario 'つぶやく' do
        fill_in 'tweet_content', with: 'はじめまして'
        expect {
          click_on 'つぶやく'
        }.to change(Tweet, :count).by(1)
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

  context '他ユーザーのホーム画面' do
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
        expect {
          click_on 'フォローする'
        }.to change(Relationship, :count).by(1)
        expect(page).to have_content "#{jiro.name} をフォローしました。"
      end
    end

    feature 'フォロー解除', type: :system do
      background do
        click_on 'フォローする'
      end

      scenario 'フォローを解除する' do
        expect {
          click_on 'フォロー解除'
        }.to change(Relationship, :count).by(-1)
        expect(page).to have_content "#{jiro.name} のフォローを解除しました。"
      end
    end
  end

  context 'ホーム画面（自分/他ユーザー共通）' do
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
