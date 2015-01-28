require 'spec_helper'

describe UsersController do

  context 'with authenticated user' do
    before { session[:user_id] = 1 }

    describe 'GET new' do
      it 'redirects to home' do
        get 'new'
        expect(response).to redirect_to home_path
      end
    end
  end

  context 'without authenticated user' do
    describe 'GET new' do
      it 'creates a new instance of User' do
        get 'new', user: Fabricate.attributes_for(:user)
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  describe 'POST create' do
    it 'passes all params to the new instance of User' do
        attributes = Fabricate.attributes_for(:user)
        post 'create', user: attributes
        expect(assigns(:user).username).to eq(attributes[:username])
        expect(assigns(:user).email).to eq(attributes[:email])
    end

    context 'new user is valid' do
      before { post 'create', user: Fabricate.attributes_for(:user) }
      
      it 'sets up session' do
        expect(session[:user_id]).to eq(User.last.id)
      end

      it 'redirects to home' do
        expect(response).to redirect_to home_path
      end
    end

    context 'new user is invalid' do
      before { post 'create', user: {username: 'Pete'} }

      it 'shows error message' do
        expect(flash[:danger]).to eq('There was a problem with your input. Please fix it.')
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end 
  end
end