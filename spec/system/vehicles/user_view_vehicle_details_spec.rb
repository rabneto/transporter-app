require 'rails_helper'

describe 'usuário vêm detalhes do veículo' do
  it 'a partir da tela inicial' do

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

    expect(page).to have_field 'Categoria', with: 'Moto'
    expect(page).to have_field 'Placa', with: 'GTY-7532'
    expect(page).to have_field 'Marca', with: 'Honda'
    expect(page).to have_field 'Modelo', with: 'Pop'
    expect(page).to have_field 'Ano de Fabricação', with: '2018'
    expect(page).to have_field 'Carga Máxima', with: '20'

  end

  it 'e coloca o veículo em manutenção' do

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
    click_on 'GTY-7532'

    click_on 'Colocar em Manutenção'

    expect(page).to have_field 'Ativo?', with: 'Em Manutenção'

  end

  it 'e reativa uma modalidade de transporte' do

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
    click_on 'GTY-7532'

    click_on 'Colocar em Manutenção'

    expect(page).to have_field 'Ativo?', with: 'Em Manutenção'

    click_on 'Ativar'

    expect(page).to have_field 'Ativo?', with: 'Ativo'

  end

  it 'e retorna' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    TransportMode.create!(name: 'Rodoviário',
                          min_range: 100,
                          max_range: 300,
                          min_weight: 50,
                          max_weight: 500,
                          tax: 200)

    visit root_path
    within('#sidebar') do
      click_on 'Modalidades de Transporte'
    end
    click_link 'Rodoviário'
    click_link 'Voltar'

    expect(current_path).to eq transport_modes_path

  end

end

