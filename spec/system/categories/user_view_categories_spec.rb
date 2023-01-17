require 'rails_helper'

describe 'usuário vê modalidades de transporte' do
  it 'a partir do menu' do
    visit root_path
    within('#sidebar') do
      click_on 'Categorias'
    end
    expect(current_path).to eq categories_path
  end

  it 'com sucesso' do
    Category.create!(name: 'Moto')

    Category.create!(name: 'Bicicleta')

    visit root_path
    within('#sidebar') do
      click_on 'Categorias'
    end

    expect(page).to have_content('Moto')
    expect(page).to have_content('Bicicleta')

  end

  it 'e não existem categorias cadastradas' do

    visit root_path
    within('#sidebar') do
      click_on 'Categorias'
    end

    expect(page).to have_content('Nenhuma categoria cadastrada')

  end
end