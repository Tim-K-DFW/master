shared_examples 'require_login' do
  it 'redirects to register page if user is not signed in' do
    clear_session
    action
    expect(response).to redirect_to register_path
  end
end