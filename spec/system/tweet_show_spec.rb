require 'rails_helper'

RSpec.feature 'tweet#show', type: :system do
  given!(:taro) { create(:user, name: 'taro', email: 'taro@example.com') }
  given!(:jiro) { create(:user, name: 'jiro', email: 'jiro@example.com') }
  given!(:taro_tweet) { create(:tweet, user: taro, content: 'taroです。') }
  given!(:jiro_tweet) { create(:tweet, user: jiro, content: 'jiroです。') }

  background do
    visit root_path
    click_on 'ログイン'
    fill_in 'Eメール', with: "#{taro.email}"
    fill_in 'パスワード', with: "#{taro.password}"
    click_on 'ログイン'
  end

  context '自分のツイート' do
    background do
      page.find('a', id: "#{taro_tweet.id}").click
    end

    context '更新' do
      scenario 'ツイートを更新する' do
        click_on '更新'
        fill_in 'tweet_content', with: 'はじめまして。'
        click_on 'つぶやく'
        expect(page).to have_content 'ツイートを更新しました。'
        expect(page).to have_content 'はじめまして。'
      end
    end

    context '削除' do
      scenario 'ツイートを削除する' do
        click_on '削除'
        expect(page).to have_content 'ツイートを削除しました。'
        expect(page).to have_no_content 'taroです。'
      end
    end

    context '返信' do
      scenario '返信する' do
        fill_in 'tweet_content', with: '自分に返信してみたり。'
        click_on '返信'
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

    context 'リツイート' do
      background do
        within '.tweet-card' do
          click_on 'リツイート'
        end
      end

      scenario 'コメントなしでリツイート' do
        within('.application-body') do
          click_on 'リツイート'
        end
        expect(page).to have_content 'リツイートしました。'
        expect(page).to have_content "#{jiro_tweet.content}"
      end

      scenario 'コメント付きでリツイート' do
        fill_in 'retweet_content', with: '拡散します！'
        within('.application-body') do
          click_on 'リツイート'
        end
        expect(page).to have_content 'リツイートしました。'
        expect(page).to have_content "#{jiro_tweet.content}"
        expect(page).to have_content '拡散します！'
      end
    end

    context '返信' do
      scenario '返信する' do
        fill_in 'tweet_content', with: 'はじめまして。taroです。'
        click_on '返信'
        expect(page).to have_content 'リプライしました。'
        expect(page).to have_content 'はじめまして。taroです。'
      end
    end
  end
end
