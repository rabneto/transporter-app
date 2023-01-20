require 'rails_helper'

describe 'usuário edita um prazo' do
  it 'a partir da home' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    tm = TransportMode.create!(name: 'Express',
                               min_range: 100,
                               max_range: 300,
                               min_weight: 5,
                               max_weight: 50,
                               tax: 200)

    Deadline.create!(min_range: 110, max_range: 200, hours: 24, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Prazos'
    end
    click_link '24 horas'

    expect(page).to have_content 'Editar Prazo'
    expect(page).to have_field 'Modalidade de Transporte', with: tm.id
    expect(page).to have_field 'Distância mínima', with: '110'
    expect(page).to have_field 'Distância máxima', with: '200'
    expect(page).to have_field 'Prazo', with: '24'
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

    Deadline.create!(min_range: 110, max_range: 200, hours: 24, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Prazos'
    end
    click_link '24 horas'

    select 'Express', from: 'Modalidade de Transporte'
    fill_in 'Distância mínima', with: '120'
    fill_in 'Distância máxima', with: '220'
    fill_in 'Prazo', with: '48'

    click_on 'Salvar'

    within('div#notice') do
      expect(page).to have_content 'Prazo atualizado com sucesso'
    end
    expect(page).to have_content '48 horas'
    expect(page).to have_content '120km / 220km'
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

    Deadline.create!(min_range: 110, max_range: 200, hours: 24, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Prazos'
    end
    click_link '24 horas'

    select '', from: 'Modalidade de Transporte'
    fill_in 'Distância mínima', with: ''
    fill_in 'Distância máxima', with: ''
    fill_in 'Prazo', with: ''

    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Não foi possível atualizar o prazo.'
    end
    within('div#errors') do
      expect(page).to have_content 'Modalidade de Transporte é obrigatório(a)'
      expect(page).to have_content 'Distância mínima não pode ficar em branco'
      expect(page).to have_content 'Distância máxima não pode ficar em branco'
      expect(page).to have_content 'Prazo não pode ficar em branco'
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

    Deadline.create!(min_range: 110, max_range: 200, hours: 24, transport_mode: tm)

    visit root_path
    within('#sidebar') do
      click_on 'Prazos'
    end
    click_link '24 horas'
    click_link 'Voltar'

    expect(current_path).to eq deadlines_path
  end
end
