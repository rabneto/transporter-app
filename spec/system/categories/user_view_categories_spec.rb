require 'rails_helper'

describe 'usuário vê categorias' do
  it 'a partir do menu' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Categorias'
    end
    expect(current_path).to eq categories_path
  end

  it 'com sucesso' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

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

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Categorias'
    end

    expect(page).to have_content('Nenhuma categoria cadastrada')

  end
end