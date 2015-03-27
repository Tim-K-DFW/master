require 'spec_helper'

feature 'a person registers with an invitation from a current user' do
  before { login(Fabricate(:user, username: 'Alice')) }

  scenario 'current user sends an invitation' do
    click_link('Invite')
    fill_in 'Friend\'s Name', with: 'Peter'
    fill_in 'Friend\'s Email Address', with: 'fake@email.com'
    click_button('Send Invitation')
    expect(page).to have_content('Invitation to Peter has been sent successfully')
  end

  scenario 'person clicks invitation link' do
    click_link('Invite')
    fill_in 'Friend\'s Name', with: 'Peter'
    fill_in 'Friend\'s Email Address', with: 'fake@email.com'
    click_button('Send Invitation')

    click_link('Sign Out')

    open_email('fake@email.com')
    current_email.click_link('MyFlix Registration')
    expect(page).to have_content('Register')
    expect(find_field('user_email').value).to eq('fake@email.com')
    expect(find_field('user_username').value).to eq('Peter')
    fill_in 'Password', with: '123'
    click_button('Sign up')
    expect(page).to have_content('Welcome, Peter!')

    click_link('People')
    expect(page).to have_content('Alice')
  end
end
