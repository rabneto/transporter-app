require 'rails_helper'

describe 'usuário vêm detalhes de uma ordem de entrega' do
  it 'a partir da tela inicial' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AS4D7FDR7R5R54T')

    Order.create!(start: '',
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
    click_link 'AS4D7FDR7R5R54T'

    expect(page).to have_field 'Código', with: 'AS4D7FDR7R5R54T'
    expect(page).to have_field 'Situação', with: 'Pendente'
    
    expect(page).to have_field('Identificação do Produto', with: 'tv 41 polegadas')
    expect(page).to have_field('Peso do Produto', with: '3000')
    expect(page).to have_field('Largura do Produto', with: '120')
    expect(page).to have_field('Altura do Produto', with: '80')
    expect(page).to have_field('Comprimento do Produto', with: '20')

    expect(page).to have_field('Endereço de Origem', with: 'Avenida B, 123')
    expect(page).to have_field('Cidade de Origem', with: 'Guarulhos')
    expect(page).to have_field('UF de Origem', with: 'SP')
    expect(page).to have_field('Endereço de destino', with: 'Av. Paulisa, 234 - Sala 605')
    expect(page).to have_field('Cidade de destino', with: 'São Paulo')
    expect(page).to have_field('UF de destino', with: 'SP')

    expect(page).to have_field('Nome do remetente', with: 'Fernando Paulo')
    expect(page).to have_field('CPF do remetente', with: '12345678978')
    expect(page).to have_field('Telefone do remetente', with: '(11) 99877-4455')
    expect(page).to have_field('E-mail do remetente', with: '')

    expect(page).to have_field('Nome do destinatário', with: 'João Guilhermo')
    expect(page).to have_field('CPF do destinatário', with: '78945678945')
    expect(page).to have_field('Telefone do destinatário', with: '(11) 98865-7854')
    expect(page).to have_field('E-mail do destinatário', with: '')

  end

  it 'e habilita a edição, se o status for pendente' do

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
    click_on 'AS4D7FDR7R5R54T'

    click_on 'Habilitar Edição'

    expect(current_path).to eq edit_order_path(o)

  end

  it 'e não habilita a edição, se o status for diferente de pendente' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AS4D7FDR7R5R54T')

    tm = TransportMode.create!(name: 'Express',
                          min_range: 1,
                          max_range: 30,
                          min_weight: 1,
                          max_weight: 15,
                          tax: 200)

    c = Category.create!(name: 'Moto')

    v = Vehicle.create!(category: c,
                        plate: 'GTY-7532',
                        brand: 'Honda',
                        model: 'Pop',
                        year: 2018,
                        max_weight: 10)

    Order.create!(start: '2023-01-21 8:00:00',
                  deadline: '2023-01-21 16:00:00',
                  delivered: '2023-01-21 15:50:00',
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
                  transport_mode_id: tm,
                  vehicle_id: v,
                  price: 150,
                  status: 3)

    visit root_path
    within('#sidebar') do
      click_on 'Ordens de Entrega'
    end
    click_on 'AS4D7FDR7R5R54T'

    expect(page).not_to have_button('Habilitar Edição')

  end

  it 'e retorna' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AS4D7FDR7R5R54T')

    Order.create!(start: '',
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
    click_link 'AS4D7FDR7R5R54T'
    click_link 'Voltar'

    expect(current_path).to eq orders_path

  end

end

