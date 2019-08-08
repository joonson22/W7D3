require 'rails_helper'

RSpec.describe User, type: :model do
  let(:incomplete_user) {User.create(username: "toby", password: "password")}
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_uniqueness_of(:username) }
      subject(:toby) { User.create(
      username: 'toby', 
      password: 'password'
      ) 
    }

  it { should validate_uniqueness_of(:session_token)}
  it { should validate_length_of(:password).is_at_least(6)}

  describe 'password encryption' do
    it 'encrypts password using bcrypt' do
      expect(BCrypt::Password).to receive(:create).with('password')

      FactoryBot.build(:user, password: 'password')
    end
  end

end
