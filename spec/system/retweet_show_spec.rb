require 'rails_helper'

RSpec.feature 'retweet#show', type: :system do
  given!(:taro) { create(:user, name: 'taro', email: 'taro@example.com') }
  given!(:jiro) { create(:user, name: 'jiro', email: 'jiro@example.com') }
  given!(:taro_tweet) { create(:tweet, user: taro, content: 'taroです。') }
  given!(:jiro_tweet) { create(:tweet, user: jiro, content: 'jiroです。') }
  given!(:taro_retweet) { create(:retweet, user: taro, tweet: jiro_tweet) }
  given!(:jiro_retweet) { create(:retweet, user: jiro, tweet: taro_tweet) }

  background do
    visit root_path
    click_on 'ログイン'
    fill_in 'Eメール', with: "#{taro.email}"
    fill_in 'パスワード', with: "#{taro.password}"
    click_on 'ログイン'
  end

  context '自分のリツイート' do
    background do
      click_on 'リツイート'
      page.find('a', id: "#{taro_retweet.id}").click
    end

    context '更新' do
      scenario 'リツイートを更新する' do
        click_on '更新'
        fill_in 'retweet_content', with: '拡散しました！'
        within('.application-body') do
          click_on 'リツイート'
        end
        expect(page).to have_content 'リツイートを更新しました。'
        expect(page).to have_content '拡散しました！'
      end
    end

    context '削除' do
      scenario 'リツイートを削除する' do
        click_on '削除'
        expect(page).to have_content 'リツイートを削除しました。'
        expect(page).to have_no_content "#{jiro_tweet.content}"
      end
    end

    context '返信' do
      scenario '返信する' do
        fill_in 'reply_content', with: '拡散しときました！'
        click_on '返信'
        expect(page).to have_content 'リプライしました。'
        expect(page).to have_content '拡散しときました！'
      end
    end
  end

  context '他ユーザのリツイート' do
    background do
      visit user_path(jiro)
      click_on 'リツイート'
      page.find('a', id: "#{jiro_retweet.id}").click
    end

    context '返信' do
      scenario '返信する' do
        fill_in 'reply_content', with: 'どんどん拡散お願いします！'
        click_on '返信'
        expect(page).to have_content 'リプライしました。'
        expect(page).to have_content 'どんどん拡散お願いします！'
      end
    end
  end
end
