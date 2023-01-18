require 'rails_helper'

describe 'usuário Cadastra uma categoria' do
  it 'a partir da tela inicial' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Categorias'
    end
    click_link 'Cadastrar Nova'

    expect(page).to have_content 'Cadastrar Categoria'
    expect(page).to have_field('Nome')
  end

  it 'com sucesso' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Categorias'
    end
    click_link 'Cadastrar Nova'

    fill_in 'Nome', with: 'Bicicleta'
    
    click_on 'Salvar'

    expect(page).to have_content 'Bicicleta'

  end

  it 'com dados incompletos' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Categorias'
    end
    click_link 'Cadastrar Nova'

    fill_in 'Nome', with: ''
    
    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Categoria não cadastrada.'
    end
    within('div#errors') do
      expect(page).to have_content 'Nome não pode ficar em branco'
    end
    
  end
end
