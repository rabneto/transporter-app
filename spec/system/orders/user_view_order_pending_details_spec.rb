require 'rails_helper'

describe 'usuário vê detalhes do orçamento de uma ordem de serviço pendente' do

  it 'a partir da tela inicial' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AS4D7FDR7R5R54T')

    o = Order.create!(start: '',
                      deadline: '',
                      delivered: '',
                      delay_reason: '',
                      distance: 25,
                      product_id: 'tv 41 polegadas',
                      product_width: 120,
                      product_height: 80,
                      product_depth: 20,
                      product_weight: 3000,
                      origin_address: 'Avenida B, 123',
                      origin_city: 'Guarulhos',
                      origin_uf: 'SP',
                      destiny_address: 'Av. Paulisa, 234 - Sala 605',
                      destiny_city: 'São Paulo',
                      destiny_uf: 'SP',
                      sender_name: 'Fernando Paulo',
                      sender_document: '12345678978',
                      sender_phone: '(11) 99877-4455',
                      sender_email: '',
                      recipient_name: 'João Guilhermo',
                      recipient_document: '78945678945',
                      recipient_email: '',
                      recipient_phone: '(11) 98865-7854',
                      transport_mode_id: nil,
                      vehicle_id: nil,
                      price: '',
                      status: 1)

    visit root_path
    within('#sidebar') do
      click_on 'Orçamentos'
    end
    
    click_on 'AS4D7FDR7R5R54T'

    expect(page).to have_content 'Gerar Orçamento'
  end

  it 'e vê os dados da ordem de serviço' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AS4D7FDR7R5R54T')

    o = Order.create!(start: '',
                      deadline: '',
                      delivered: '',
                      delay_reason: '',
                      distance: 25,
                      product_id: 'tv 41 polegadas',
                      product_width: 120,
                      product_height: 80,
                      product_depth: 20,
                      product_weight: 3000,
                      origin_address: 'Avenida B, 123',
                      origin_city: 'Guarulhos',
                      origin_uf: 'SP',
                      destiny_address: 'Av. Paulisa, 234 - Sala 605',
                      destiny_city: 'São Paulo',
                      destiny_uf: 'SP',
                      sender_name: 'Fernando Paulo',
                      sender_document: '12345678978',
                      sender_phone: '(11) 99877-4455',
                      sender_email: '',
                      recipient_name: 'João Guilhermo',
                      recipient_document: '78945678945',
                      recipient_email: '',
                      recipient_phone: '(11) 98865-7854',
                      transport_mode_id: nil,
                      vehicle_id: nil,
                      price: '',
                      status: 1)

    visit root_path
    within('#sidebar') do
      click_on 'Orçamentos'
    end
    
    click_on 'AS4D7FDR7R5R54T'

    expect(page).to have_field('Código', with: 'AS4D7FDR7R5R54T')
    expect(page).to have_field('Situação', with: 'Pendente')
    expect(page).to have_field('Identificação do Produto', with: 'tv 41 polegadas')
    expect(page).to have_field('Peso do Produto', with: '3000')
    expect(page).to have_field('Largura do Produto', with: '120')
    expect(page).to have_field('Altura do Produto', with: '80')
    expect(page).to have_field('Comprimento do Produto', with: '20')
    expect(page).to have_field('Endereço de Origem', with: 'Avenida B, 123')
    expect(page).to have_field('Cidade de Origem', with: 'Guarulhos')
    expect(page).to have_field('UF de Origem', with: 'SP')
    expect(page).to have_field('Endereço de Destino', with: 'Av. Paulisa, 234 - Sala 605')
    expect(page).to have_field('Cidade de Destino', with: 'São Paulo')
    expect(page).to have_field('UF de Destino', with: 'SP')
    
  end

  it 'e retorna' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AS4D7FDR7R5R54T')

    o = Order.create!(start: '',
                      deadline: '',
                      delivered: '',
                      delay_reason: '',
                      distance: 25,
                      product_id: 'tv 41 polegadas',
                      product_width: 120,
                      product_height: 80,
                      product_depth: 20,
                      product_weight: 3000,
                      origin_address: 'Avenida B, 123',
                      origin_city: 'Guarulhos',
                      origin_uf: 'SP',
                      destiny_address: 'Av. Paulisa, 234 - Sala 605',
                      destiny_city: 'São Paulo',
                      destiny_uf: 'SP',
                      sender_name: 'Fernando Paulo',
                      sender_document: '12345678978',
                      sender_phone: '(11) 99877-4455',
                      sender_email: '',
                      recipient_name: 'João Guilhermo',
                      recipient_document: '78945678945',
                      recipient_email: '',
                      recipient_phone: '(11) 98865-7854',
                      transport_mode_id: nil,
                      vehicle_id: nil,
                      price: '',
                      status: 1)

    TransportMode.create!(name: 'Rodoviário',
                          min_range: 100,
                          max_range: 300,
                          min_weight: 50,
                          max_weight: 500,
                          tax: 200)

    visit root_path
    within('#sidebar') do
      click_on 'Orçamentos'
    end
    click_on 'AS4D7FDR7R5R54T'
    click_link 'Voltar'

    expect(current_path).to eq orders_pending_path

  end

end