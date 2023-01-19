require 'rails_helper'

describe 'usuário vê modalidades de transporte' do

  it 'a partir do menu' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Modalidades de Transporte'
    end
    expect(current_path).to eq transport_modes_path
  end

  it 'com sucesso' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    TransportMode.create!(name: 'Rodoviário',
                          min_range: 100,
                          max_range: 300,
                          min_weight: 50,
                          max_weight: 500,
                          tax: 200)

    TransportMode.create!(name: 'Marítimo',
                          min_range: 1000,
                          max_range: 35000,
                          min_weight: 5000,
                          max_weight: 100000,
                          tax: 12000)

    visit root_path
    within('#sidebar') do
      click_on 'Modalidades de Transporte'
    end

    expect(page).to have_content('Rodoviário')
    expect(page).to have_content('100 / 300')
    expect(page).to have_content('50kg / 500kg')

    expect(page).to have_content('Marítimo')
    expect(page).to have_content('1000 / 35000')
    expect(page).to have_content('5000kg / 100000kg')

  end

  it 'e não existem fornecedores cadastrados' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Modalidades de Transporte'
    end

    expect(page).to have_content('Nenhuma modalidade cadastrada')

  end
end