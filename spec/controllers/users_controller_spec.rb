require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'Get #show' do
    it 'renders the show template' do
      User.create!(username: 'whatever', password: 'password')
      get :show, params: { id: User.last.id }
      expect(response).to render_template(:show)
    end
    
    # context "if user doesn't exist" do
    #   it "is not a success" do
    #     begin
    #       get :show, id: -1
    #     rescue
    #       ActiveRecord:RecordNotFound
    #     end

    #     expect(response).not_to render_template(:show)
    #   end
    # end
  end

  describe 'Get #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end 
  end

  # describe 'Get #edit' do
  #   it 'renders the edit template' do
  #     get :edit
  #     expect(response).to render_template(:edit)
  #   end 
  # end

  describe 'Post #create' do
    let(:user_params) do
      { user: {
        username: 'toby',
        password: 'password'
      }}
    end
    
    context "with invalid params" do
      it "renders the new template" do
        post :create, params: { user: {username: 'Sir', password: ""} }
        expect(response).to render_template(:new)
      end
    end
    context 'with valid params' do
      it 'logs in a user' do
        post :create, params: { user: {username: 'Sir', password: "password"} }

        user = User.find_by(username: 'Sir')
        expect(session[:session_token]).to eq(user.session_token)
      end

      it 'redirects to users show page' do
        post :create, params: { user: {username: 'testing', password: "password"} }

        user = User.find_by(username: 'testing')
        expect(response).to redirect_to(user_url(user))
      end
    end
  end

  # describe 'Patch #update' do
  #   let(:user_params) do
  #     { user: {
  #       username: 'toby2',
  #       password: 'password2'
  #     }}
  #   end

  #   context 'with valid params' do
  #     it 'updates the user' do
  #       post :create, params: user_params

  #       user = User.find_by(username: 'toby')
  #       expect(session[:session_token]).to eq(user.session_token)
  #     end

  #     it 'redirects to users show page' do
  #       post :create, params: user_params

  #       user = User.find_by(username: 'toby')
  #       expect(response).to redirect_to(user_url(user))
  #     end
      # end
  # end
end
