require 'rails_helper'

RSpec.feature 'reply#show', type: :system do
  given!(:taro) { create(:user, name: 'taro', email: 'taro@example.com') }
  given!(:jiro) { create(:user, name: 'jiro', email: 'jiro@example.com') }
  given!(:taro_tweet) { create(:tweet, user: taro, content: 'taroです。') }
  given!(:jiro_tweet) { create(:tweet, user: jiro, content: 'jiroです。') }
  given!(:taro_reply) { create(:reply, user: taro, tweet: jiro_tweet, content: 'こんにちは。taroです。') }
  given!(:jiro_reply) { create(:reply, user: jiro, tweet: taro_tweet, content: 'こんにちは。jiroです。') }

  background do
    visit root_path
    click_on 'ログイン'
    fill_in 'Eメール', with: "#{taro.email}"
    fill_in 'パスワード', with: "#{taro.password}"
    click_on 'ログイン'
  end

  context '自分のリプライ' do
    background do
      click_on 'リプライ'
      page.find('a', id: "#{taro_reply.id}").click
    end

    context '更新' do
      scenario 'リプライを更新する' do
        click_on '更新'
        fill_in 'reply_content', with: 'はじめまして。taroです。'
        click_on '返信'
        expect(page).to have_content 'リプライを更新しました。'
        expect(page).to have_content 'はじめまして。taroです。'
      end
    end

    context '削除' do
      scenario 'リプライを削除する' do
        click_on '削除'
        expect(page).to have_content 'リプライを削除しました。'
        expect(page).to have_no_content "#{taro_reply.content}"
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
      expect(page).to have_content "#{jiro_reply.tweet.content}"
      expect(page).to have_content "#{jiro_reply.content}"
    end
  end
end
