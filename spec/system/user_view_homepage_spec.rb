require 'rails_helper'

describe 'usuário vê tela inicial' do
  it 'com sucesso' do
    visit root_path

    within('header') do
      expect(page).to have_content 'Transporter APP'
    end
  end
end