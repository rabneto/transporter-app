require 'rails_helper'

describe 'usuário vêm detalhes do modelo de transporte' do
  it 'a partir da tela inicial' do

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

    expect(page).to have_field 'Nome', with: 'Rodoviário'
    expect(page).to have_field 'Distância Mínima', with: '100'
    expect(page).to have_field 'Distância Máxima', with: '300'
    expect(page).to have_field 'Peso Mínimo', with: '50'
    expect(page).to have_field 'Peso Máximo', with: '500'
    expect(page).to have_field 'Taxa Fixa', with: '200,00'

  end

  it 'e desativa uma modalidade de transporte' do

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
    click_on 'Rodoviário'

    click_on 'Desabilitar'

    expect(page).to have_field 'Ativo?', with: 'Desabilitado'

  end

  it 'e reativa uma modalidade de transporte' do

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
    click_on 'Rodoviário'

    click_on 'Desabilitar'

    expect(page).to have_field 'Ativo?', with: 'Desabilitado'

    click_on 'Habilitar'

    expect(page).to have_field 'Ativo?', with: 'Habilitado'

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

