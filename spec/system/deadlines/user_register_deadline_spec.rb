require 'rails_helper'

describe 'usuário Cadastra um prazo' do
  it 'a partir da tela inicial' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Prazos'
    end
    click_link 'Cadastrar Novo'

    expect(page).to have_content 'Cadastrar Prazo'
    expect(page).to have_field 'Modalidade de Transporte'
    expect(page).to have_field 'Distância mínima'
    expect(page).to have_field 'Distância máxima'
    expect(page).to have_field 'Prazo'
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

    TransportMode.create!(name: 'Express',
                          min_range: 100,
                          max_range: 300,
                          min_weight: 5,
                          max_weight: 50,
                          tax: 200)

    visit root_path
    within('#sidebar') do
      click_on 'Prazos'
    end
    click_link 'Cadastrar Novo'

    select 'Express', from: 'Modalidade de Transporte'
    fill_in 'Distância mínima', with: '110'
    fill_in 'Distância máxima', with: '200'
    fill_in 'Prazo', with: '48'

    click_on 'Salvar'

    expect(page).to have_content '48 horas'
    expect(page).to have_content '110km / 200km'
    expect(page).to have_content 'Express'
  end

  it 'com dados incompletos' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    TransportMode.create!(name: 'Express Urbana',
                          min_range: 50,
                          max_range: 150,
                          min_weight: 1,
                          max_weight: 10,
                          tax: 200)

    TransportMode.create!(name: 'Express',
                          min_range: 100,
                          max_range: 300,
                          min_weight: 5,
                          max_weight: 50,
                          tax: 200)

    visit root_path
    within('#sidebar') do
      click_on 'Prazos'
    end
    click_link 'Cadastrar Novo'

    select '', from: 'Modalidade de Transporte'
    fill_in 'Distância mínima', with: ''
    fill_in 'Distância máxima', with: ''
    fill_in 'Prazo', with: ''

    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Prazo não cadastrado.'
    end
    within('div#errors') do
      expect(page).to have_content 'Modalidade de Transporte é obrigatório(a)'
      expect(page).to have_content 'Distância mínima não pode ficar em branco'
      expect(page).to have_content 'Distância máxima não pode ficar em branco'
      expect(page).to have_content 'Prazo não pode ficar em branco'
    end
  end
end
