require 'rails_helper'

RSpec.feature 'retweet#show', type: :system do
  given!(:taro) { create(:user, name: 'taro', email: 'taro@example.com') }
  given!(:jiro) { create(:user, name: 'jiro', email: 'jiro@example.com') }
  given!(:taro_tweet) { create(:tweet, user: taro, content: 'taroです。') }
  given!(:jiro_tweet) { create(:tweet, user: jiro, content: 'jiroです。') }
  given!(:taro_retweet) { create(:retweet, user: taro, tweet: jiro_tweet) }
  given!(:jiro_retweet) { create(:retweet, user: jiro, tweet: taro_tweet) }

  background do
    login_as taro, scope: :user
  end

  context '自分のリツイート' do
    background do
      visit user_path(taro)
      click_on 'リツイート'
      page.find('a', id: "#{taro_retweet.id}").click
    end

    feature '更新', type: :system do
      scenario 'リツイートを更新する' do
        click_on '更新'
        fill_in 'retweet_content', with: '拡散しました！'
        within('.application-body') do
          expect {
            click_on 'リツイート'
          }.to change(Retweet, :count).by(0)
        end
        expect(page).to have_content 'リツイートを更新しました。'
        expect(page).to have_content '拡散しました！'
      end
    end

    feature '削除', type: :system do
      scenario 'リツイートを削除する' do
        expect {
          click_on '削除'
        }.to change(Retweet, :count).by(-1)
        expect(page).to have_content 'リツイートを削除しました。'
        expect(page).to have_no_content "#{jiro_tweet.content}"
      end
    end

    feature '返信', type: :system do
      scenario '返信する' do
        fill_in 'tweet_content', with: '拡散しときました！'
        expect {
          click_on '返信'
        }.to change(taro_retweet.tweet.replies, :count).by(1)
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

    feature '返信', type: :system do
      scenario '返信する' do
        fill_in 'tweet_content', with: 'どんどん拡散お願いします！'
        expect {
          click_on '返信'
        }.to change(jiro_retweet.tweet.replies, :count).by(1)
        expect(page).to have_content 'リプライしました。'
        expect(page).to have_content 'どんどん拡散お願いします！'
      end
    end
  end
end
