require 'rails_helper'

describe 'usuário edita uma categoria' do
  it 'a partir da home' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    c = Category.create!(name: 'Bicicleta')

    visit root_path
    within('#sidebar') do
      click_on 'Categorias'
    end
    click_link 'Bicicleta'

    expect(page).to have_content 'Editar Categoria'
    expect(page).to have_field 'Nome', with: 'Bicicleta'
  end

  it 'com sucesso' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    c = Category.create!(name: 'Bicicleta')

    visit root_path
    within('#sidebar') do
    click_on 'Categorias'
    end
    click_link 'Bicicleta'
    
    fill_in 'Nome', with: 'Bike'
    
    click_on 'Salvar'

    within('div#notice') do
      expect(page).to have_content 'Categoria atualizada com sucesso'
    end
    expect(page).to have_content 'Bike'
  end

  it 'e mantêm os campos obrigatórios' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    c = Category.create!(name: 'Bicicleta')

    visit root_path
    within('#sidebar') do
      click_on 'Categorias'
    end
    click_link 'Bicicleta'
    
    fill_in 'Nome', with: ''
    
    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Não foi possível atualizar a categoria.'
    end
    within('div#errors') do
      expect(page).to have_content 'Nome não pode ficar em branco'
    end
  end

  it 'e desativa' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    c = Category.create!(name: 'Bicicleta')

    visit root_path
    within('#sidebar') do
      click_on 'Categorias'
    end
    click_on 'Bicicleta'

    click_on 'Desativar'

    expect(page).to have_selector(:link_or_button, 'Ativar')
  end

  it 'e reativa' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    c = Category.create!(name: 'Bicicleta')

    visit root_path
    within('#sidebar') do
      click_on 'Categorias'
    end
    click_on 'Bicicleta'

    click_on 'Desativar'

    expect(page).to have_selector(:link_or_button, 'Ativar')

    click_on 'Ativar'

    expect(page).to have_selector(:link_or_button, 'Desativar')
  end

  it 'e retorna' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    Category.create!(name: 'Bicicleta')

    visit root_path
    within('#sidebar') do
      click_on 'Categorias'
    end
    click_link 'Bicicleta'
    click_link 'Voltar'

    expect(current_path).to eq categories_path

  end
end
