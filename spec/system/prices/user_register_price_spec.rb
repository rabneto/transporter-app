require 'rails_helper'

describe 'usuário Cadastra um preço' do
  it 'a partir da tela inicial' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Preços'
    end
    click_link 'Cadastrar Novo'

    expect(page).to have_content 'Cadastrar Preço'
    expect(page).to have_field('Modalidade de Transporte')
    expect(page).to have_field('Peso mínimo')
    expect(page).to have_field('Peso máximo')
    expect(page).to have_field('Preço por km')
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
      click_on 'Preços'
    end
    click_link 'Cadastrar Novo'

    select 'Express', from: 'Modalidade de Transporte'
    fill_in 'Peso mínimo', with: '10'
    fill_in 'Peso máximo', with: '50'
    fill_in 'Preço por km', with: '80,00'
    
    click_on 'Salvar'

    expect(page).to have_content 'R$ 80,00'

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
      click_on 'Preços'
    end
    click_link 'Cadastrar Novo'

    select '', from: 'Modalidade de Transporte'
    fill_in 'Peso mínimo', with: ''
    fill_in 'Peso máximo', with: ''
    fill_in 'Preço por km', with: ''
    
    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Preço não cadastrado.'
    end
    within('div#errors') do
      expect(page).to have_content 'Modalidade de Transporte é obrigatório(a)'
      expect(page).to have_content 'Peso mínimo não pode ficar em branco'
      expect(page).to have_content 'Peso máximo não pode ficar em branco'
      expect(page).to have_content 'Preço por km não pode ficar em branco'
    end
    
  end

  it 'e não cadastra se o peso mínimo for menor que o peso mínimo da modalidade de transporte' do

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
      click_on 'Preços'
    end
    click_link 'Cadastrar Novo'

    select 'Express', from: 'Modalidade de Transporte'
    fill_in 'Peso mínimo', with: '1'
    fill_in 'Peso máximo', with: '40'
    fill_in 'Preço por km', with: '80,00'
    
    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Preço não cadastrado.'
    end
    within('div#errors') do
      expect(page).to have_content 'Peso mínimo Não pode ser menor que o Peso Mínimo da Modalidade de Transporte'
    end

  end

  it 'e não cadastra se o peso máximo for maior que o peso máximo da modalidade de transporte' do

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
      click_on 'Preços'
    end
    click_link 'Cadastrar Novo'

    select 'Express', from: 'Modalidade de Transporte'
    fill_in 'Peso mínimo', with: '10'
    fill_in 'Peso máximo', with: '100'
    fill_in 'Preço por km', with: '80,00'
    
    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Preço não cadastrado.'
    end
    within('div#errors') do
      expect(page).to have_content 'Peso máximo Não pode ser maior que o Peso Máximo da Modalidade de Transporte'
    end

  end
end
