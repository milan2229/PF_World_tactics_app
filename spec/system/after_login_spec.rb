require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let!(:post) { create(:post, user: user) }
  let(:other_post) { create(:post, user: other_user) }

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[password]', with: user.password
      fill_in 'user[email]', with: user.email
      click_button 'ログイン'
    end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }

      it '戦術投稿を押すと、投稿画面に遷移する' do
        post_link = find_all('a')[1].native.inner_text
        post_link = post_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link post_link
        is_expected.to eq '/posts/new'
      end
      it '戦術投稿一覧を押すと、投稿一覧画面に遷移する' do
        posts_link = find_all('a')[2].native.inner_text
        posts_link = posts_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link posts_link
        is_expected.to eq '/posts'
      end
      it 'ユーザー一覧を押すと、ユーザー一覧画面に遷移する' do
        users_link = find_all('a')[3].native.inner_text
        users_link = users_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link users_link
        is_expected.to eq '/users'
      end
      it 'マイページを押すと、自分の詳細画面に遷移する' do
        mypage_link = find_all('a')[4].native.inner_text
        mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link mypage_link
        is_expected.to eq '/users/1'
      end
      it 'お問い合わせを押すと、お問い合わせ画面に遷移する' do
        contact_link = find_all('a')[5].native.inner_text
        contact_link = contact_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link contact_link
        is_expected.to eq '/inquiries/new'
      end
      it 'ログアウトを押すと、トップページに遷移する' do
        logout_link = find_all('a')[6].native.inner_text
        logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link logout_link
        is_expected.to eq '/'
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit posts_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts'
      end
      it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい' do
        expect(page).to have_link post.title, href: post_path(post)
      end
      it '自分の投稿と他人の投稿のオピニオンが表示される' do
        expect(page).to have_content post.body
      end
    end

    context 'サイドバーの確認' do
      it '自分の名前と紹介文が表示される' do
        expect(page).to have_content user.name
      end
      it '「名前」と表示される' do
        expect(page).to have_content '名前'
      end
      it '「いいねした投稿」と表示される' do
        expect(page).to have_content 'いいねした投稿'
      end
      it 'フォローボタンが表示される' do
        expect(page).to have_content 'フォロー'
      end
      it 'フォロワーボタンが表示される' do
        expect(page).to have_content 'フォロワー'
      end
      it 'フォローしている人一覧リンクが存在する' do
        expect(page).to have_link '', href: user_users_followed_path(user)
      end
      it 'フォローされている人一覧リンクが存在する' do
        expect(page).to have_link '', href: user_users_follower_path(user)
      end
      it 'いいねランキング一覧のリンクが存在する' do
        expect(page).to have_link '', href: user_users_favorites_path(user)
      end
    end

  end

  describe 'ユーザーの投稿テスト' do
    before do
      visit new_post_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq new_post_path
      end
    context '投稿成功のテスト' do
      before do
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 20)
      end
      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿' }.to change(user.posts, :count).by(1)
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        click_button '投稿'
        expect(current_path).to eq '/posts'
      end
    end
      it '「記事を投稿する」と表示される' do
         expect(page).to have_content '記事を投稿する'
      end
      it '投稿ボタンが表示される' do
        expect(page).to have_button '投稿'
      end
     it 'titleフォームが表示される' do
        expect(page).to have_field 'post[title]'
      end
      it 'titleフォームに値が入っていない' do
        expect(find_field('post[title]').text).to be_blank
      end
      it 'bodyフォームが表示される' do
        expect(page).to have_field 'post[body]'
      end
      it 'bodyフォームに値が入っていない' do
        expect(find_field('post[body]').text).to be_blank
      end
    end
 end


  describe 'お問い合わせテスト' do
    before do
      visit new_inquiry_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq new_inquiry_path
      end
    context 'お問い合わせ成功のテスト' do
      before do
        fill_in 'inquiry[name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'inquiry[email]', with: Faker::Lorem.characters(number: 20)
        fill_in 'inquiry[message]', with: Faker::Lorem.characters(number: 20)
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        click_button '送信'
        expect(current_path).to eq '/posts'
      end
    end
      it '「お問い合わせフォーム」と表示される' do
         expect(page).to have_content 'お問い合わせフォーム'
      end
      it '送信ボタンが表示される' do
        expect(page).to have_button '送信'
      end
    it 'nameフォームが表示される' do
        expect(page).to have_field 'inquiry[name]'
      end
      it 'nameフォームに値が入っていない' do
        expect(find_field('inquiry[name]').text).to be_blank
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'inquiry[email]'
      end
      it 'emailフォームに値が入っていない' do
        expect(find_field('inquiry[email]').text).to be_blank
      end
      it 'messageフォームが表示される' do
        expect(page).to have_field 'inquiry[message]'
      end
      it 'messageフォームに値が入っていない' do
        expect(find_field('inquiry[message]').text).to be_blank
      end
    end
 end

  describe 'ユーザ一覧画面のテスト' do
    before do
      visit users_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users'
      end
      it '自分の名前が表示される' do
        expect(page).to have_content user.name
      end
      it '名前でshowリンクになっている' do
        expect(page).to have_link user.name, href: user_path(user)
      end
    end

  context 'サイドバーの確認' do
      it '自分の名前と紹介文が表示される' do
        expect(page).to have_content user.name
      end
      it '「名前」と表示される' do
        expect(page).to have_content '名前'
      end
      it '「いいねした投稿」と表示される' do
        expect(page).to have_content 'いいねした投稿'
      end
      it 'フォローボタンが表示される' do
        expect(page).to have_content 'フォロー'
      end
      it 'フォロワーボタンが表示される' do
        expect(page).to have_content 'フォロワー'
      end
      it 'フォローしている人一覧リンクが存在する' do
        expect(page).to have_link '', href: user_users_followed_path(user)
      end
      it 'フォローされている人一覧リンクが存在する' do
        expect(page).to have_link '', href: user_users_follower_path(user)
      end
      it 'いいねランキング一覧のリンクが存在する' do
        expect(page).to have_link '', href: user_users_favorites_path(user)
      end
    end
  end

  describe '自分のユーザ詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '投稿一覧のユーザ画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(user)
      end
      it '投稿一覧に自分の投稿のtitleが表示され、リンクが正しい' do
        expect(page).to have_content post.title
        expect(page).to have_link post.title, href: post_path(post)
      end
    end



  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end
      it 'Update Userボタンが表示される' do
        expect(page).to have_button '変更を保存'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_name = user.name
        @user_old_intrpduction = user.introduction
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
        click_button '変更を保存'
      end

      it 'nameが正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'introductionが正しく更新される' do
        expect(user.reload.introduction).not_to eq @user_old_intrpduction
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
  
  end
 end
end






