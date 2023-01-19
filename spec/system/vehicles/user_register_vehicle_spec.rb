require 'rails_helper'

describe 'usuário Cadastra um veículo' do
  it 'a partir da tela inicial' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Veículos'
    end
    click_link 'Cadastrar Novo'

    expect(page).to have_content 'Cadastrar Veículo'
    expect(page).to have_field('Categoria')
    expect(page).to have_field('Placa')
    expect(page).to have_field('Marca')
    expect(page).to have_field('Modelo')
    expect(page).to have_field('Ano de Fabricação')
    expect(page).to have_field('Carga Máxima')
    
  end

  it 'com sucesso' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    Category.create!(name: 'Moto')
    Category.create!(name: 'Carro')

    visit root_path
    within('#sidebar') do
      click_on 'Veículos'
    end
    click_link 'Cadastrar Novo'

    select 'Carro', from: 'Categoria'
    fill_in 'Placa', with: 'EUW-2303'
    fill_in 'Marca', with: 'FIAT'
    fill_in 'Modelo', with: 'Uno'
    fill_in 'Ano de Fabricação', with: '2018'
    fill_in 'Carga Máxima', with: '50'
        
    click_on 'Salvar'

    expect(page).to have_field('Categoria', with: 'Carro')
    expect(page).to have_field('Placa', with: 'EUW-2303')
    expect(page).to have_field('Marca', with: 'FIAT')
    expect(page).to have_field('Modelo', with: 'Uno')
    expect(page).to have_field('Ano de Fabricação', with: '2018')
    expect(page).to have_field('Carga Máxima', with: '50')

  end

  it 'com dados incompletos' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    
    Category.create!(name: 'Moto')
    Category.create!(name: 'Carro')

    visit root_path
    within('#sidebar') do
      click_on 'Veículos'
    end
    click_link 'Cadastrar Novo'

    select '', from: 'Categoria'
    fill_in 'Placa', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Modelo', with: ''
    fill_in 'Ano de Fabricação', with: ''
    fill_in 'Carga Máxima', with: ''
    
    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Veículo não cadastrado.'
    end
    within('div#errors') do
      expect(page).to have_content 'Categoria é obrigatório(a)'
      expect(page).to have_content 'Placa não pode ficar em branco'
      expect(page).to have_content 'Marca não pode ficar em branco'
      expect(page).to have_content 'Modelo não pode ficar em branco'
      expect(page).to have_content 'Ano de Fabricação não pode ficar em branco'
      expect(page).to have_content 'Carga Máxima não pode ficar em branco'
    end
    
  end
end
