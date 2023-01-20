require 'rails_helper'

describe 'usuário vê Prazos' do
  it 'a partir do menu' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Prazos'
    end
    expect(current_path).to eq deadlines_path
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

    Deadline.create!(min_range: 101, max_range: 150, hours: 24, transport_mode: tm)
    Deadline.create!(min_range: 151, max_range: 200, hours: 48, transport_mode: tm)
    Deadline.create!(min_range: 201, max_range: 300, hours: 72, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Prazos'
    end

    expect(page).to have_content('Express')
    expect(page).to have_content('101km / 150km')
    expect(page).to have_content('24 horas')

    expect(page).to have_content('Express')
    expect(page).to have_content('151km / 200km')
    expect(page).to have_content('48 horas')

    expect(page).to have_content('Express')
    expect(page).to have_content('201km / 300km')
    expect(page).to have_content('72 horas')
  end

  it 'e não existem prazos cadastrados' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Prazos'
    end

    expect(page).to have_content('Nenhuma configuração de prazo cadastrada')
  end
end
