require 'rails_helper'

describe 'usuário editar uma modalidade de transporte' do
  it 'a partir da página de detalhes' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    tm = TransportMode.create!(name: 'Rodoviário',
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
    click_on 'Editar'

    expect(page).to have_content 'Editar Modalidade de Transporte'
    expect(page).to have_field 'Nome', with: 'Rodoviário'
    expect(page).to have_field 'Distância Mínima', with: '100'
    expect(page).to have_field 'Distância Máxima', with: '300'
    expect(page).to have_field 'Peso Mínimo', with: '50'
    expect(page).to have_field 'Peso Máximo', with: '500'
    expect(page).to have_field 'Taxa Fixa', with: '200'
  end

  it 'com sucesso' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    tm = TransportMode.create!(name: 'Rodoviário',
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
    click_on 'Editar'

    fill_in 'Nome', with: 'Rodofluvial'
    fill_in 'Distância Mínima', with: '120'
    fill_in 'Distância Máxima', with: '320'
    fill_in 'Peso Mínimo', with: '55'
    fill_in 'Peso Máximo', with: '550'
    fill_in 'Taxa Fixa', with: '220'

    click_on 'Salvar'

    within('div#notice') do
      expect(page).to have_content 'Modelo de produto atualizado com sucesso'
    end
    expect(page).to have_field('Nome', with: 'Rodofluvial')
    expect(page).to have_field('Distância Mínima', with: '120')
    expect(page).to have_field('Distância Máxima', with: '320')
    expect(page).to have_field('Peso Mínimo', with: '55')
    expect(page).to have_field('Peso Máximo', with: '550')
    expect(page).to have_field('Taxa Fixa', with: '220')
  end

  it 'e mantêm os campos obrigatórios' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)
    
    tm = TransportMode.create!(name: 'Rodoviário',
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
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Distância Mínima', with: ''
    fill_in 'Distância Máxima', with: ''
    fill_in 'Peso Mínimo', with: ''
    fill_in 'Peso Máximo', with: ''
    fill_in 'Taxa Fixa', with: ''

    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Não foi possível atualizar o modelo de produto.'
    end
    within('div#errors') do
      expect(page).to have_content 'Nome não pode ficar em branco'
      expect(page).to have_content 'Distância Mínima não pode ficar em branco'
      expect(page).to have_content 'Distância Máxima não pode ficar em branco'
      expect(page).to have_content 'Peso Mínimo não pode ficar em branco'
      expect(page).to have_content 'Peso Máximo não pode ficar em branco'
      expect(page).to have_content 'Taxa Fixa não pode ficar em branco'
    end

  end
end
