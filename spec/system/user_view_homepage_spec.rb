require 'rails_helper'

describe 'usuário vê tela inicial' do
  it 'com sucesso' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)
    
    visit root_path

    within('header') do
      expect(page).to have_content 'Transporter APP'
    end
  end
end