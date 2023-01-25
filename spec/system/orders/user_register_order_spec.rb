require 'rails_helper'

describe 'usuário Cadastra uma ordem de entrega' do
  it 'a partir da tela inicial' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Ordens de Entrega'
    end
    click_link 'Cadastrar Nova'

    expect(page).to have_content 'Cadastrar Ordem de Entrega'
    expect(page).to have_field('Identificação do Produto')
    expect(page).to have_field('Peso do Produto')
    expect(page).to have_field('Largura do Produto')
    expect(page).to have_field('Altura do Produto')
    expect(page).to have_field('Comprimento do Produto')

    expect(page).to have_field('Endereço de Origem')
    expect(page).to have_field('Cidade de Origem')
    expect(page).to have_field('UF de Origem')
    expect(page).to have_field('Endereço de Destino')
    expect(page).to have_field('Cidade de Destino')
    expect(page).to have_field('UF de Destino')
    expect(page).to have_field('Distância')

    expect(page).to have_field('Nome do remetente')
    expect(page).to have_field('CPF do remetente')
    expect(page).to have_field('Telefone do remetente')
    expect(page).to have_field('E-mail do remetente')

    expect(page).to have_field('Nome do destinatário')
    expect(page).to have_field('CPF do destinatário')
    expect(page).to have_field('Telefone do destinatário')
    expect(page).to have_field('E-mail do destinatário')
  end

  it 'com sucesso' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Ordens de Entrega'
    end
    click_link 'Cadastrar Nova'

    fill_in('Identificação do Produto', with: 'Tv 40 polegadas')
    fill_in('Peso do Produto', with: '5000')
    fill_in('Largura do Produto', with: '110')
    fill_in('Altura do Produto', with: '80')
    fill_in('Comprimento do Produto', with: '20')

    fill_in('Endereço de Origem', with: 'Rua das Flores, 34')
    fill_in('Cidade de Origem', with: 'Belém')
    fill_in('UF de Origem', with: 'PA')
    fill_in('Endereço de Destino', with: 'Passagem Cabrobro, 3567')
    fill_in('Cidade de Destino', with: 'Ananindeua')
    fill_in('UF de Destino', with: 'PA')
    fill_in('Distância', with: '25')

    fill_in('Nome do remetente', with: 'Fernando Paulo')
    fill_in('CPF do remetente', with: '12345678945')
    fill_in('Telefone do remetente', with: '91987412365')
    fill_in('E-mail do remetente', with: 'fpaulo@gmail.com')

    fill_in('Nome do destinatário', with: 'Daniela Cruz')
    fill_in('CPF do destinatário', with: '96325874103')
    fill_in('Telefone do destinatário', with: '91985227744')
    fill_in('E-mail do destinatário', with: 'dbcruz@gmail.com')

    click_on 'Salvar'

    within('div#notice') do
      expect(page).to have_content 'Ordem de Entrega cadastrada com sucesso.'
    end
    expect(page).to have_field('Identificação do Produto', with: 'Tv 40 polegadas')
    expect(page).to have_field('Peso do Produto', with: '5000')
    expect(page).to have_field('Largura do Produto', with: '110')
    expect(page).to have_field('Altura do Produto', with: '80')
    expect(page).to have_field('Comprimento do Produto', with: '20')

    expect(page).to have_field('Endereço de Origem', with: 'Rua das Flores, 34')
    expect(page).to have_field('Cidade de Origem', with: 'Belém')
    expect(page).to have_field('UF de Origem', with: 'PA')
    expect(page).to have_field('Endereço de Destino', with: 'Passagem Cabrobro, 3567')
    expect(page).to have_field('Cidade de Destino', with: 'Ananindeua')
    expect(page).to have_field('UF de Destino', with: 'PA')
    expect(page).to have_field('Distância')

    expect(page).to have_field('Nome do remetente', with: 'Fernando Paulo')
    expect(page).to have_field('CPF do remetente', with: '12345678945')
    expect(page).to have_field('Telefone do remetente', with: '91987412365')
    expect(page).to have_field('E-mail do remetente', with: 'fpaulo@gmail.com')

    expect(page).to have_field('Nome do destinatário', with: 'Daniela Cruz')
    expect(page).to have_field('CPF do destinatário', with: '96325874103')
    expect(page).to have_field('Telefone do destinatário', with: '91985227744')
    expect(page).to have_field('E-mail do destinatário', with: 'dbcruz@gmail.com')

  end

  it 'com dados incompletos' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Ordens de Entrega'
    end
    click_link 'Cadastrar Nova'
    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Ordem de Entrega não cadastrada.'
    end
    within('div#errors') do
      expect(page).to have_content 'Distância não pode ficar em branco'
      expect(page).to have_content 'Identificação do Produto não pode ficar em branco'
      expect(page).to have_content 'Largura do Produto não pode ficar em branco'
      expect(page).to have_content 'Altura do Produto não pode ficar em branco'
      expect(page).to have_content 'Comprimento do Produto não pode ficar em branco'
      expect(page).to have_content 'Peso do Produto não pode ficar em branco'
      expect(page).to have_content 'Endereço de Origem não pode ficar em branco'
      expect(page).to have_content 'Cidade de Origem não pode ficar em branco'
      expect(page).to have_content 'UF de Origem não pode ficar em branco'
      expect(page).to have_content 'Nome do remetente não pode ficar em branco'
      expect(page).to have_content 'CPF do remetente não pode ficar em branco'
      expect(page).to have_content 'Telefone do remetente não pode ficar em branco'
      expect(page).to have_content 'Endereço de Destino não pode ficar em branco'
      expect(page).to have_content 'Cidade de Destino não pode ficar em branco'
      expect(page).to have_content 'UF de Destino não pode ficar em branco'
      expect(page).to have_content 'Nome do destinatário não pode ficar em branco'
      expect(page).to have_content 'CPF do destinatário não pode ficar em branco'
      expect(page).to have_content 'Telefone do destinatário não pode ficar em branco'
    end
    
  end

end