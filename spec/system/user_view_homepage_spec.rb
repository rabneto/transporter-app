require 'rails_helper'

describe 'usuário vê tela inicial' do
  it 'com sucesso' do
    visit root_path

    expect(page).to have_content 'Bem vindos'
  end
end