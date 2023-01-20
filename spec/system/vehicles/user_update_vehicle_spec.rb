require 'rails_helper'

describe 'usuário editar umm veículo' do
  it 'a partir da página de detalhes' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    category = Category.create!(name: 'Moto')
    Vehicle.create!(category: category,
                    plate: 'GTY-7532',
                    brand: 'Honda',
                    model: 'Pop',
                    year: 2018,
                    max_weight: 20)

    visit root_path
    within('#sidebar') do
      click_on 'Veículos'
    end
    click_link 'GTY-7532'
    click_on 'Editar'

    expect(page).to have_content 'Editar Veículo'
    expect(page).to have_field 'Categoria', with: category.id
    expect(page).to have_field 'Placa', with: 'GTY-7532'
    expect(page).to have_field 'Marca', with: 'Honda'
    expect(page).to have_field 'Modelo', with: 'Pop'
    expect(page).to have_field 'Ano de Fabricação', with: '2018'
    expect(page).to have_field 'Carga Máxima', with: '20'
  end

  it 'com sucesso' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    category = Category.create!(name: 'Moto')
    second_category = Category.create!(name: 'Carro')

    Vehicle.create!(category: category,
                    plate: 'GTY-7532',
                    brand: 'Honda',
                    model: 'Pop',
                    year: 2018,
                    max_weight: 20)

    visit root_path
    within('#sidebar') do
    click_on 'Veículos'
    end
    click_link 'GTY-7532'
    click_on 'Editar'

    select 'Carro', from: 'Categoria'
    fill_in 'Placa', with: 'EUW-2303'
    fill_in 'Marca', with: 'FIAT'
    fill_in 'Modelo', with: 'Uno'
    fill_in 'Ano de Fabricação', with: '2018'
    fill_in 'Carga Máxima', with: '50'

    click_on 'Salvar'

    within('div#notice') do
      expect(page).to have_content 'Veículo atualizado com sucesso'
    end
    expect(page).to have_field('Categoria', with: 'Carro')
    expect(page).to have_field('Placa', with: 'EUW-2303')
    expect(page).to have_field('Marca', with: 'FIAT')
    expect(page).to have_field('Modelo', with: 'Uno')
    expect(page).to have_field('Ano de Fabricação', with: '2018')
    expect(page).to have_field('Carga Máxima', with: '50')
  end

  it 'e mantêm os campos obrigatórios' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)
    
    category = Category.create!(name: 'Moto')
    Vehicle.create!(category: category,
                    plate: 'GTY-7532',
                    brand: 'Honda',
                    model: 'Pop',
                    year: 2018,
                    max_weight: 20)
                    
    visit root_path
    within('#sidebar') do
      click_on 'Veículos'
    end
    click_link 'GTY-7532'
    click_on 'Editar'

    select '', from: 'Categoria'
    fill_in 'Placa', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Modelo', with: ''
    fill_in 'Ano de Fabricação', with: ''
    fill_in 'Carga Máxima', with: ''

    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Não foi possível atualizar o veículo.'
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
