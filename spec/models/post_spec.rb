require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:user) { create(:user) }

    context 'titleカラム' do
      it "空白でないこと" do
        expect(FactoryBot.build(:post, title: "")).not_to be_valid
      end
    end

    context 'bodyカラム' do
      it "空白でないこと" do
        expect(FactoryBot.build(:post, body: "")).not_to be_valid
      end
    end

    describe 'アソシエーションのテスト' do
      context 'Userモデルとの関係' do
        it 'N:1となっている' do
          expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
        end
      end

      context 'Favoriteモデルとの関係' do
        it 'N:1となっている' do
          expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
        end
      end

      context 'PostCommentモデルとの関係' do
        it 'N:1となっている' do
          expect(Post.reflect_on_association(:post_comments).macro).to eq :has_many
        end
      end
    end
  end
end
