require 'rails_helper'

describe 'usuário vêm detalhes do modelo de transporte' do
  it 'a partir da tela inicial' do
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
    expect(page).to have_field 'Taxa Fixa', with: '200'

  end

  it 'e retrorna' do

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

