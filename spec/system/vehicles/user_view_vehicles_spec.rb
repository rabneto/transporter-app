require 'rails_helper'

describe 'usuário vê veículos' do
  it 'a partir do menu' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Veículos'
    end
    expect(current_path).to eq vehicles_path
  end

  it 'com sucesso' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    category = Category.create!(name: 'Carros')
    Vehicle.create!(plate: 'EUW-2389', brand: 'FIAT', model: 'Ducato', year: 2020, max_weight: 2000, category: category)
    Vehicle.create!(plate: 'NTT-1245', brand: 'Ford', model: 'Ranger', year: 2019, max_weight: 5000, category: category)

    visit root_path
    within('#sidebar') do
      click_on 'Veículos'
    end

    expect(page).to have_content('FIAT')
    expect(page).to have_content('Ducato')
    expect(page).to have_content('EUW-2389')
    expect(page).to have_content('Ford')
    expect(page).to have_content('Ranger')
    expect(page).to have_content('NTT-1245')

  end

  it 'e não existem veículos cadastrados' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Veículos'
    end

    expect(page).to have_content('Nenhum veículo cadastrado')

  end
end