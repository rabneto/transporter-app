require 'rails_helper'

describe 'usuário pesquisa por veículos cuja carga máxima fica entre o peso máximo e mínimo da modalidade de transporte' do

  it 'e vê os veículos' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    TransportMode.create!(name: 'Expressa',
                          min_range: 100,
                          max_range: 300,
                          min_weight: 50,
                          max_weight: 100,
                          tax: 200)

    category = Category.create!(name: 'Moto')

    Vehicle.create!(category: category,
                              plate: 'GTT-7741',
                              brand: 'Honda',
                              model: 'Broz',
                              year: 2018,
                              max_weight: 70)

    Vehicle.create!(category: category,
                    plate: 'GTY-7532',
                    brand: 'Honda',
                    model: 'Pop',
                    year: 2018,
                    max_weight: 20)

    visit root_path
    within('#sidebar') do
      click_on 'Modalidades de Transporte'
    end
    click_link 'Expressa'

    within('table') do
      expect(page).to have_content 'Broz'
      expect(page).to have_content 'GTT-7741'

      expect(page).not_to have_content 'Pop'
      expect(page).not_to have_content 'GTY-7532'
    end

  end

  it 'e pesquisa por veículos' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    TransportMode.create!(name: 'Expressa',
                          min_range: 100,
                          max_range: 300,
                          min_weight: 50,
                          max_weight: 100,
                          tax: 200)

    category = Category.create!(name: 'Moto')

    Vehicle.create!(category: category,
                              plate: 'GTT-7741',
                              brand: 'Honda',
                              model: 'Broz',
                              year: 2018,
                              max_weight: 70)

    Vehicle.create!(category: category,
                    plate: 'GTY-7532',
                    brand: 'Honda',
                    model: 'Pop',
                    year: 2018,
                    max_weight: 60)

    visit root_path
    within('#sidebar') do
      click_on 'Modalidades de Transporte'
    end
    click_link 'Expressa'

    within('form#pesquisa') do
      fill_in 'q', with: 'GTT'
      click_on 'Pesquisar'
    end

    within('table') do
      expect(page).to have_content 'Broz'
      expect(page).to have_content 'GTT-7741'

      expect(page).not_to have_content 'Pop'
      expect(page).not_to have_content 'GTY-7532'
    end

  end

end