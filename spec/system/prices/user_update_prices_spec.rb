require 'rails_helper'

describe 'usuário edita um preço' do
  it 'a partir da home' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    tm = TransportMode.create!(name: 'Express',
                               min_range: 100,
                               max_range: 300,
                               min_weight: 5,
                               max_weight: 50,
                               tax: 200)

    p = Price.create!(min_weight: 5, max_weight: 10, km_price: 80, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Preços'
    end
    click_link 'R$ 80'

    expect(page).to have_content 'Editar Preço'
    expect(page).to have_field 'Modalidade de Transporte', with: tm.id
    expect(page).to have_field 'Peso mínimo', with: '5'
    expect(page).to have_field 'Peso máximo', with: '10'
    expect(page).to have_field 'Preço por km', with: '80,00'
  end

  it 'com sucesso' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    TransportMode.create!(name: 'Express Urbana',
                          min_range: 50,
                          max_range: 150,
                          min_weight: 1,
                          max_weight: 10,
                          tax: 200)

    tm = TransportMode.create!(name: 'Express',
                               min_range: 100,
                               max_range: 300,
                               min_weight: 5,
                               max_weight: 50,
                               tax: 200)

    Price.create!(min_weight: 5, max_weight: 10, km_price: 80, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Preços'
    end
    click_link 'R$ 80,00'

    select 'Express Urbana', from: 'Modalidade de Transporte'
    fill_in 'Peso mínimo', with: '1'
    fill_in 'Peso máximo', with: '5'
    fill_in 'Preço por km', with: '25,00'

    click_on 'Salvar'

    within('div#notice') do
      expect(page).to have_content 'Preço atualizado com sucesso'
    end
    expect(page).to have_content 'R$ 25,00'
    expect(page).to have_content '1kg / 5kg'
    expect(page).to have_content 'Express Urbana'
  end

  it 'e mantêm os campos obrigatórios' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    TransportMode.create!(name: 'Express Urbana',
                          min_range: 50,
                          max_range: 150,
                          min_weight: 1,
                          max_weight: 10,
                          tax: 200)

    tm = TransportMode.create!(name: 'Express',
                               min_range: 100,
                               max_range: 300,
                               min_weight: 5,
                               max_weight: 50,
                               tax: 200)

    p = Price.create!(min_weight: 5, max_weight: 10, km_price: 80, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Preços'
    end
    click_link 'R$ 80,00'

    select '', from: 'Modalidade de Transporte'
    fill_in 'Peso mínimo', with: ''
    fill_in 'Peso máximo', with: ''
    fill_in 'Preço por km', with: ''

    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Não foi possível atualizar o preço.'
    end
    within('div#errors') do
      expect(page).to have_content 'Modalidade de Transporte é obrigatório(a)'
      expect(page).to have_content 'Peso mínimo não pode ficar em branco'
      expect(page).to have_content 'Peso máximo não pode ficar em branco'
      expect(page).to have_content 'Preço por km não pode ficar em branco'
    end
  end

  it 'e retorna' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    tm = TransportMode.create!(name: 'Express',
                               min_range: 100,
                               max_range: 300,
                               min_weight: 5,
                               max_weight: 50,
                               tax: 200)

    Price.create!(min_weight: 5, max_weight: 10, km_price: 80, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Preços'
    end
    click_link 'R$ 80'
    click_link 'Voltar'

    expect(current_path).to eq prices_path
  end

  it 'e não atualiza se o peso mínimo for menor que o peso mínimo da modalidade de transporte' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    TransportMode.create!(name: 'Express Urbana',
                          min_range: 50,
                          max_range: 150,
                          min_weight: 1,
                          max_weight: 10,
                          tax: 200)

    tm = TransportMode.create!(name: 'Express',
                               min_range: 100,
                               max_range: 300,
                               min_weight: 5,
                               max_weight: 50,
                               tax: 200)

    Price.create!(min_weight: 5, max_weight: 10, km_price: 80, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Preços'
    end
    click_link 'R$ 80'

    select 'Express Urbana', from: 'Modalidade de Transporte'
    fill_in 'Peso mínimo', with: '0'
    fill_in 'Peso máximo', with: '10'
    fill_in 'Preço por km', with: '25'

    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Não foi possível atualizar o preço.'
    end
    within('div#errors') do
      expect(page).to have_content 'Peso mínimo Não pode ser menor que o Peso Mínimo da Modalidade de Transporte'
    end
  end

  it 'e não atualiza se o peso máximo for maior que o peso máximo da modalidade de transporte' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    TransportMode.create!(name: 'Express Urbana',
                          min_range: 50,
                          max_range: 150,
                          min_weight: 1,
                          max_weight: 10,
                          tax: 200)

    tm = TransportMode.create!(name: 'Express',
                               min_range: 100,
                               max_range: 300,
                               min_weight: 5,
                               max_weight: 50,
                               tax: 200)

    Price.create!(min_weight: 5, max_weight: 10, km_price: 80, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Preços'
    end
    click_link 'R$ 80'

    select 'Express Urbana', from: 'Modalidade de Transporte'
    fill_in 'Peso mínimo', with: '40'
    fill_in 'Peso máximo', with: '80'
    fill_in 'Preço por km', with: '25'

    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Não foi possível atualizar o preço.'
    end
    within('div#errors') do
      expect(page).to have_content 'Peso máximo Não pode ser maior que o Peso Máximo da Modalidade de Transporte'
    end
  end
end
