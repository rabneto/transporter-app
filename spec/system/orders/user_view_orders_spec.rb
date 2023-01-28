require 'rails_helper'

describe 'usuário vê ordens de entrega' do
  it 'a partir do menu' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Ordens de Entrega'
    end
    expect(current_path).to eq orders_path
  end

  it 'com sucesso' do
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
      click_on 'Ordens de Entrega'
    end

    expect(page).to have_content('AS4D7FDR7R5R54T')
    expect(page).to have_content('Fernando Paulo')
    expect(page).to have_content('João Guilhermo')
    expect(page).to have_content('Pendente')
  end

  it 'e não existem ordens de entrega cadastradas' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Ordens de Entrega'
    end

    expect(page).to have_content('Nenhuma ordem de entrega cadastrada')
  end

  it 'e pesquisa por ordem de entrega pelo código' do
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

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('WSL4D8FER4R87R9')

    o = Order.create!(start: '',
                      deadline: '',
                      delivered: '',
                      delay_reason: '',
                      distance: 25,
                      product_id: 'Fogão 5 bocas Consul',
                      product_width: 150,
                      product_height: 250,
                      product_depth: 120,
                      product_weight: 30_000,
                      origin_address: 'Avenida B, 123',
                      origin_city: 'Guarulhos',
                      origin_uf: 'SP',
                      destiny_address: 'Av. Paulisa, 234 - Sala 605',
                      destiny_city: 'São Paulo',
                      destiny_uf: 'SP',
                      sender_name: 'Flávio Feio',
                      sender_document: '12345678978',
                      sender_phone: '(11) 99877-4455',
                      sender_email: '',
                      recipient_name: 'Marcelo Vieira Pereira',
                      recipient_document: '78945678945',
                      recipient_email: '',
                      recipient_phone: '(11) 98865-7854',
                      transport_mode_id: nil,
                      vehicle_id: nil,
                      price: '',
                      status: 1)

    visit root_path
    within('#sidebar') do
      click_on 'Ordens de Entrega'
    end

    search_field = find_by_id('q')
    search_field.set('AS4D7FDR7R5R54T')
    click_on 'Pesquisar'

    within('table') do
      expect(page).to have_content 'AS4D7FDR7R5R54T'
      expect(page).to have_content 'Fernando Paulo'
      expect(page).to have_content 'João Guilhermo'

      expect(page).not_to have_content 'WSL4D8FER4R87R9'
      expect(page).not_to have_content 'Flávio Feio'
      expect(page).not_to have_content 'Marcelo Vieira Pereira'
    end
  end

end
