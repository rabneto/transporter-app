require 'rails_helper'

describe 'usuário vê preços' do
  it 'a partir do menu' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Preços'
    end
    expect(current_path).to eq prices_path
  end

  it 'com sucesso' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    tm = TransportMode.create!(name: 'Express',
                          min_range: 100,
                          max_range: 300,
                          min_weight: 1,
                          max_weight: 50,
                          tax: 200)

    Price.create!(min_weight: 1, max_weight: 10, km_price: 80, transport_mode: tm)
    Price.create!(min_weight: 11, max_weight: 20, km_price: 50, transport_mode: tm)
    Price.create!(min_weight: 21, max_weight: 30, km_price: 30, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Preços'
    end

    expect(page).to have_content('Express')
    expect(page).to have_content('1kg / 10kg')
    expect(page).to have_content('R$ 80,00')

    expect(page).to have_content('Express')
    expect(page).to have_content('11kg / 20kg')
    expect(page).to have_content('R$ 50,00')

    expect(page).to have_content('Express')
    expect(page).to have_content('21kg / 30kg')
    expect(page).to have_content('R$ 30,00')

  end

  it 'e não existem preços cadastrados' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Preços'
    end

    expect(page).to have_content('Nenhuma configuração de preço cadastrada')

  end
end