require 'rails_helper'

describe 'usuário edita umum preço' do
  it 'a partir da home' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    tm = TransportMode.create!(name: 'Express',
                               min_range: 100,
                               max_range: 300,
                               min_weight: 5,
                               max_weight: 50,
                               tax: 200)

    p = Price.create!(min_weight: 1, max_weight: 10, km_price: 80, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Preços'
    end
    click_link 'R$ 80'

    expect(page).to have_content 'Editar Preço'
    expect(page).to have_field 'Modalidade de Transporte', with: tm.id
    expect(page).to have_field 'Peso mínimo', with: '1'
    expect(page).to have_field 'Peso máximo', with: '10'
    expect(page).to have_field 'Preço por km', with: '80'
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

    p = Price.create!(min_weight: 1, max_weight: 10, km_price: 80, transport_mode: tm)

    visit root_path
    within('#sidebar') do
    click_on 'Preços'
    end
    click_link 'R$ 80'
    
    select 'Express', from: 'Modalidade de Transporte'
    fill_in 'Peso mínimo', with: '11'
    fill_in 'Peso máximo', with: '20'
    fill_in 'Preço por km', with: '250'
    
    click_on 'Salvar'

    within('div#notice') do
      expect(page).to have_content 'Preço atualizado com sucesso'
    end
    expect(page).to have_content 'R$ 250'
    expect(page).to have_content '11kg / 20kg'
    expect(page).to have_content 'Express'

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

    p = Price.create!(min_weight: 1, max_weight: 10, km_price: 80, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Preços'
    end
    click_link 'R$ 80'
    
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

    p = Price.create!(min_weight: 1, max_weight: 10, km_price: 80, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Preços'
    end
    click_link 'R$ 80'
    click_link 'Voltar'

    expect(current_path).to eq prices_path

  end
end
