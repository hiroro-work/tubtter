require 'rails_helper'

RSpec.feature 'tweet#show', type: :system do
  given!(:taro) { create(:user, name: 'taro', email: 'taro@example.com') }
  given!(:jiro) { create(:user, name: 'jiro', email: 'jiro@example.com') }
  given!(:taro_tweet) { create(:tweet, user: taro, content: 'taroです。') }
  given!(:jiro_tweet) { create(:tweet, user: jiro, content: 'jiroです。') }

  background do
    login_as taro, scope: :user
  end

  context '自分のツイート' do
    background do
      visit user_path(taro)
      page.find('a', id: "#{taro_tweet.id}").click
    end

    feature '更新', type: :system do
      scenario 'ツイートを更新する' do
        click_on '更新'
        fill_in 'tweet_content', with: 'はじめまして。'
        expect {
          click_on 'つぶやく'
        }.to change(Tweet, :count).by(0)
        expect(page).to have_content 'ツイートを更新しました。'
        expect(page).to have_content 'はじめまして。'
      end
    end

    feature '削除', type: :system do
      scenario 'ツイートを削除する' do
        expect {
          click_on '削除'
        }.to change(Tweet, :count).by(-1)
        expect(page).to have_content 'ツイートを削除しました。'
        expect(page).to have_no_content 'taroです。'
      end
    end

    feature '返信', type: :system do
      scenario '返信する' do
        fill_in 'tweet_content', with: '自分に返信してみたり。'
        expect {
          click_on '返信'
        }.to change(Tweet, :count).by(1)
        expect(page).to have_content 'リプライしました。'
        expect(page).to have_content '自分に返信してみたり。'
      end
    end
  end

  context '他ユーザのツイート' do
    background do
      visit user_path(jiro)
      page.find('a', id: "#{jiro_tweet.id}").click
    end

    feature 'リツイート', type: :system do
      background do
        within '.tweet-card' do
          click_on 'リツイート'
        end
      end

      scenario 'コメントなしでリツイート' do
        within('.application-body') do
          expect {
            click_on 'リツイート'
          }.to change(Retweet, :count).by(1)
        end
        expect(page).to have_content 'リツイートしました。'
        expect(page).to have_content "#{jiro_tweet.content}"
      end

      scenario 'コメント付きでリツイート' do
        fill_in 'retweet_content', with: '拡散します！'
        within('.application-body') do
          expect {
            click_on 'リツイート'
          }.to change(Retweet, :count).by(1)
        end
        expect(page).to have_content 'リツイートしました。'
        expect(page).to have_content "#{jiro_tweet.content}"
        expect(page).to have_content '拡散します！'
      end
    end

    feature '返信', type: :system do
      scenario '返信する' do
        fill_in 'tweet_content', with: 'はじめまして。taroです。'
        expect {
          click_on '返信'
        }.to change(Tweet, :count).by(1)
        expect(page).to have_content 'リプライしました。'
        expect(page).to have_content 'はじめまして。taroです。'
      end
    end
  end
end
