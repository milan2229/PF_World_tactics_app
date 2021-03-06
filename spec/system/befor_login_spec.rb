require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end

      it 'ログインリンクが表示される: 画面中央が「ログイン」である' do
        log_in_link = find_all('a')[4].native.inner_text
        expect(log_in_link).to match("ログイン")
      end
      it 'ログインリンクの内容が正しい' do
        log_in_link = find_all('a')[4].native.inner_text
        expect(page).to have_link log_in_link, href: new_user_session_path
      end
    end

    it '新規登録リンクが表示される: 画面中央が「新規登録」である' do
      sign_up_link = find_all('a')[5].native.inner_text
      expect(sign_up_link).to match("新規登録")
    end
    it '新規登録リンクの内容が正しい' do
      sign_up_link = find_all('a')[5].native.inner_text
      expect(page).to have_link sign_up_link, href: new_user_registration_path
    end
  end

  describe 'アバウト画面のテスト' do
    before do
      visit '/homes/about'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/homes/about'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content 'World Tactics'
      end
      it '投稿一覧リンクが表示される: 左上から1番目のリンクが「投稿一覧」である' do
        posts_link = find_all('a')[1].native.inner_text
        expect(posts_link).to match("投稿一覧")
      end
      it 'Aboutリンクが表示される: 左上から2番目のリンクが「About」である' do
        about_link = find_all('a')[2].native.inner_text
        expect(about_link).to match("About")
      end
      it 'ゲストログインリンクが表示される: 左上から3番目のリンクが「ゲストログイン」である' do
        users_guest_link = find_all('a')[3].native.inner_text
        expect(users_guest_link).to match("ゲストログイン")
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it '投稿一覧を押すと、サインイン画面に遷移する' do
        home_link = find_all('a')[1].native.inner_text
        home_link = home_link.delete(' ')
        home_link.gsub!(/\n/, '')
        click_link home_link
        is_expected.to eq '/users/sign_in'
      end
      it 'Aboutを押すと、アバウト画面に遷移する' do
        about_link = find_all('a')[2].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/homes/about'
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[4].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expected.to eq '/users/sign_in'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「新規登録」と表示される' do
        expect(page).to have_content '新規会員登録'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Sign up'
      end
    end

    # context '新規登録成功のテスト' do
    #   before do
    #     fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
    #     fill_in 'user[email]', with: Faker::Internet.email
    #     fill_in 'user[password]', with: 'password'
    #     fill_in 'user[password_confirmation]', with: 'password'
    #   end

    #   it '正しく新規登録される' do
    #     expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
    #   end
    #   it '新規登録後のリダイレクト先が、投稿一覧になっている' do
    #     click_button 'Sign up'
    #     expect(current_path).to eq '/posts'
    #   end
    # end
  end

  describe 'ユーザログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end

      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'emailフォームは表示されない' do
        expect(page).not_to have_field 'email'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_content '新規会員登録'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[password]', with: user.password
        fill_in 'user[email]', with: user.email
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、ログインしたユーザの詳細画面になっている' do
        expect(current_path).to eq '/posts'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[password]', with: ''
        fill_in 'user[email]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[password]', with: user.password
      fill_in 'user[email]', with: user.email
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it 'タイトルが表示される' do
        expect(page).to have_content 'World Tactics'
      end
      it '投稿フォームリンクが表示される: 左上から1番目のリンクが「投稿フォーム」である' do
        post_link = find_all('a')[1].native.inner_text
        expect(post_link).to match("戦術投稿フォーム")
      end
      it '投稿一覧リンクが表示される: 左上から2番目のリンクが「投稿一覧」である' do
        posts_link = find_all('a')[2].native.inner_text
        expect(posts_link).to match("戦術投稿一覧")
      end
      it 'ユーザー一覧リンクが表示される: 左上から3番目のリンクが「ゲストログイン(閲覧用)」である' do
        users_guest_link = find_all('a')[3].native.inner_text
        expect(users_guest_link).to match("ユーザー一覧")
      end
      it 'マイページリンクが表示される: 左上から4番目のリンクが「マイページ」である' do
        mypage_link = find_all('a')[4].native.inner_text
        expect(mypage_link).to match("マイページ")
      end
      it 'お問い合わせリンクが表示される: 左上から5番目のリンクが「お問い合わせ」である' do
        contact_link = find_all('a')[5].native.inner_text
        expect(contact_link).to match("お問い合わせ")
      end
      it 'ログアウトリンクが表示される: 左上から7番目のリンクが「ログアウト」である' do
        logout_link = find_all('a')[7].native.inner_text
        expect(logout_link).to match("ログアウト")
      end
      it '通知リンクが表示される: 左上から6番目のリンクが「通知」である' do
        notification_link = find_all('a')[6].native.inner_text
        expect(notification_link).to match("通知")
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[password]', with: user.password
      fill_in 'user[email]', with: user.email
      click_button 'ログイン'
      logout_link = find_all('a')[7].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてAbout画面へのリンクが存在する' do
        expect(page).to have_link '', href: '/homes/about'
      end
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてゲストログインリンクが存在する' do
        expect(page).to have_link '', href: '/posts'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end
