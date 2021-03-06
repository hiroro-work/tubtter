require 'rails_helper'

RSpec.feature 'reply(tweet)#show', type: :system do
  given!(:taro) { create(:user, name: 'taro', email: 'taro@example.com') }
  given!(:jiro) { create(:user, name: 'jiro', email: 'jiro@example.com') }
  given!(:taro_tweet) { create(:tweet, user: taro, content: 'taroです。') }
  given!(:jiro_tweet) { create(:tweet, user: jiro, content: 'jiroです。') }
  given!(:taro_reply) { create(:tweet, user: taro, parent_tweet: jiro_tweet, content: 'こんにちは。taroです。') }
  given!(:jiro_reply) { create(:tweet, user: jiro, parent_tweet: taro_tweet, content: 'こんにちは。jiroです。') }

  background do
    login_as taro, scope: :user
  end

  context '自分のリプライ' do
    background do
      visit user_path(taro)
      click_on 'リプライ'
      page.find('a', id: "#{taro_reply.id}").click
    end

    feature '更新', type: :system do
      scenario 'リプライを更新する' do
        click_on '更新'
        fill_in 'tweet_content', with: 'はじめまして。taroです。'
        expect {
          click_on 'つぶやく'
        }.to change(Tweet, :count).by(0)
        expect(page).to have_content 'ツイートを更新しました。'
        expect(page).to have_content 'はじめまして。taroです。'
      end
    end

    feature '削除', type: :system do
      scenario 'リプライを削除する' do
        expect {
          click_on '削除'
        }.to change(Tweet, :count).by(-1)
        expect(page).to have_content 'ツイートを削除しました。'
        expect(page).to have_no_content "#{taro_reply.content}"
      end
    end

    feature '返信', type: :system do
      scenario 'リプライに返信する' do
        fill_in 'tweet_content', with: 'リプライにリプライ！'
        expect {
          click_on '返信'
        }.to change(Tweet, :count).by(1)
        expect(page).to have_content 'リプライしました。'
        expect(page).to have_content 'リプライにリプライ！'
      end
    end
  end

  context '他ユーザのリプライ' do
    background do
      visit user_path(jiro)
      click_on 'リプライ'
      page.find('a', id: "#{jiro_reply.id}").click
    end

    scenario 'リプライを表示する' do
      expect(page).to have_content "#{jiro_reply.parent_tweet.content}"
      expect(page).to have_content "#{jiro_reply.content}"
    end

    feature '返信', type: :system do
      scenario 'リプライに返信する' do
        fill_in 'tweet_content', with: 'リプライにリプライ！'
        expect {
          click_on '返信'
        }.to change(Tweet, :count).by(1)
        expect(page).to have_content 'リプライしました。'
        expect(page).to have_content 'リプライにリプライ！'
      end
    end
  end
end
