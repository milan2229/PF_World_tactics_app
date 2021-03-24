require 'rails_helper'

  RSpec.describe 'Inquiryモデルのテスト', type: :model do
    describe 'バリデーションのテスト' do
      subject { inquiry.valid? }

      context 'nameカラム' do
      it "空白でないこと" do
        expect(FactoryBot.build(:inquiry, name: "")).to_not be_valid
      end
    end

      context 'emailカラム' do
      it "空白でないこと" do
        expect(FactoryBot.build(:inquiry, email: "")).to_not be_valid
      end
    end

      context 'messageカラム' do
      it "空白でないこと" do
        expect(FactoryBot.build(:inquiry, message: "")).to_not be_valid
      end
    end

 end
end