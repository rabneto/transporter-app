require 'rails_helper'

describe 'usuário Cadastra uma modalidade de transporte' do
  it 'a partir da tela inicial' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Modalidades de Transporte'
    end
    click_link 'Cadastrar Nova'

    expect(page).to have_content 'Cadastrar Modalidade de Transporte'
    expect(page).to have_field('Nome')
    expect(page).to have_field('Distância Mínima')
    expect(page).to have_field('Distância Máxima')
    expect(page).to have_field('Peso Mínimo')
    expect(page).to have_field('Peso Máximo')
    expect(page).to have_field('Taxa Fixa')
  end

  it 'com sucesso' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Modalidades de Transporte'
    end
    click_link 'Cadastrar Nova'

    fill_in 'Nome', with: 'Fluvial'
    fill_in 'Distância Mínima', with: '400'
    fill_in 'Distância Máxima', with: '800'
    fill_in 'Peso Mínimo', with: '150'
    fill_in 'Peso Máximo', with: '300'
    fill_in 'Taxa Fixa', with: '250'

    click_on 'Salvar'

    expect(page).to have_field('Nome', with: 'Fluvial')
    expect(page).to have_field('Distância Mínima', with: '400')
    expect(page).to have_field('Distância Máxima', with: '800')
    expect(page).to have_field('Peso Mínimo', with: '150')
    expect(page).to have_field('Peso Máximo', with: '300')
    expect(page).to have_field('Taxa Fixa', with: '250')

  end

  it 'com dados incompletos' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Modalidades de Transporte'
    end
    click_link 'Cadastrar Nova'

    fill_in 'Nome', with: ''
    fill_in 'Distância Mínima', with: ''
    fill_in 'Distância Máxima', with: ''
    fill_in 'Peso Mínimo', with: ''
    fill_in 'Peso Máximo', with: ''
    fill_in 'Taxa Fixa', with: ''

    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Modalidade de Transporte não cadastrado.'
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
