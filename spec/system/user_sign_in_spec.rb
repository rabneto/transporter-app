require 'rails_helper'

describe 'usuário se autentica' do
  it 'com sucesso' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')

    visit new_user_session_path

    expect(current_path).to eq new_user_session_path
    
    within('form') do
      fill_in 'user[email]', with: 'root@gmail.com'
      fill_in 'user[password]', with: '123456'
      click_on 'Entrar'
    end

    within('ul.navbar-nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Root'
    end
    within('div#notice') do
      expect(page).to have_content 'Login efetuado com sucesso.'
    end
  end

  it 'e faz logout' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    
    within('ul.navbar-nav') do

      click_on 'Sair'

      within('h1') do
        expect(page).to have_content 'Bem-Vindo'
      end
      expect(page).not_to have_button 'Entrar'
      
    end
    within('div#notice') do
      expect(page).to have_content 'Logout efetuado com sucesso.'
    end
  end
end