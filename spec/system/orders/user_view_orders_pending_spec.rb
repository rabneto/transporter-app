require 'rails_helper'

describe 'usuário vê orçamentos pendentes' do
  it 'a partir do menu' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Orçamentos'
    end
    expect(current_path).to eq orders_pending_path
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

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('XYZ23FGTR56YU99')

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
                  sender_name: 'João Pessoa',
                  sender_document: '12345678978',
                  sender_phone: '(11) 99877-4455',
                  sender_email: '',
                  recipient_name: 'Guilhermo Urquiola',
                  recipient_document: '78945678945',
                  recipient_email: '',
                  recipient_phone: '(11) 98865-7854',
                  transport_mode_id: tm,
                  vehicle_id: v,
                  price: 150,
                  status: 3)

    visit root_path
    within('#sidebar') do
      click_on 'Orçamentos'
    end

    expect(page).to have_content('AS4D7FDR7R5R54T')
    expect(page).to have_content('Fernando Paulo')
    expect(page).to have_content('João Guilhermo')
    expect(page).to have_content('Pendente')

    expect(page).not_to have_content('XYZ23FGTR56YU99')
    expect(page).not_to have_content('João Pessoa')
    expect(page).not_to have_content('Guilhermo Urquiola')
    expect(page).not_to have_content('Entregue')

  end

  it 'e vê detalhes de uma ordem de transporte pendente' do
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

    expect(current_path).to eq order_pending_path(o.id)

    expect(page).to have_field('Código', with: 'AS4D7FDR7R5R54T')
    expect(page).to have_field('Situação', with: 'Pendente')

  end

  it 'e inicia a entrega' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AS4D7FDR7R5R54T')

    tm = TransportMode.create!(name: 'Expressa',
                               min_range: 1,
                               max_range: 20,
                               min_weight: 1,
                               max_weight: 20,
                               tax: 20)

    Price.create!(min_weight: 1, max_weight: 20, km_price: 0.5, transport_mode: tm)
    Deadline.create!(min_range: 1, max_range: 20, hours: 6, transport_mode: tm)

    c = Category.create!(name: 'Moto')

    Vehicle.create!(category: c,
                    plate: 'GTY-7532',
                    brand: 'Honda',
                    model: 'Pop',
                    year: 2018,
                    max_weight: 20)

    o = Order.create!(start: '',
                      deadline: '',
                      delivered: '',
                      delay_reason: '',
                      distance: 10,
                      product_id: 'tv 41 polegadas',
                      product_width: 120,
                      product_height: 80,
                      product_depth: 20,
                      product_weight: 5,
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

    click_on "Iniciar Entrega"

    expect(current_path).to eq order_path(o)

    expect(page).to have_field('Código', with: 'AS4D7FDR7R5R54T')
    expect(page).to have_field('Situação', with: 'Saiu para entrega')
    expect(page).to have_field('Modalidade', with: 'Expressa')
    expect(page).to have_field('Veículo', with: 'GTY-7532')

  end

  it 'e não inicia a entrega se não houver veículos disponíveis' do

    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('AS4D7FDR7R5R54T')

    tm = TransportMode.create!(name: 'Expressa',
                               min_range: 1,
                               max_range: 20,
                               min_weight: 1,
                               max_weight: 20,
                               tax: 20)

    Price.create!(min_weight: 1, max_weight: 20, km_price: 0.5, transport_mode: tm)
    Deadline.create!(min_range: 1, max_range: 20, hours: 6, transport_mode: tm)

    c = Category.create!(name: 'Moto')

    v = Vehicle.create!(category: c,
                    plate: 'GTY-7532',
                    brand: 'Honda',
                    model: 'Pop',
                    year: 2018,
                    max_weight: 20)

    v.disable!

    o = Order.create!(start: '',
                      deadline: '',
                      delivered: '',
                      delay_reason: '',
                      distance: 10,
                      product_id: 'tv 41 polegadas',
                      product_width: 120,
                      product_height: 80,
                      product_depth: 20,
                      product_weight: 5,
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

    click_on "Iniciar Entrega"

    expect(current_path).to eq order_pending_path(o)

    within('div#alert') do
      expect(page).to have_content 'Não é possível iniciar esta ordem de entrega. Nenhum veículo desta modalidade está disponível.'
    end
    
  end

  it 'e não existem orçamentos pendentes' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

    visit root_path
    within('#sidebar') do
      click_on 'Orçamentos'
    end

    expect(page).to have_content('Nenhum orçamento pendente')
  end

  it 'e pesquisa por orçamentos pelo código' do
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

    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('XYZ23FGTR56YU99')

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

    o = Order.create!(start: '2023-01-21 8:00:00',
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
                      sender_name: 'João Pessoa',
                      sender_document: '12345678978',
                      sender_phone: '(11) 99877-4455',
                      sender_email: '',
                      recipient_name: 'Guilhermo Urquiola',
                      recipient_document: '78945678945',
                      recipient_email: '',
                      recipient_phone: '(11) 98865-7854',
                      transport_mode_id: 1,
                      vehicle_id: v,
                      price: 150,
                      status: 3)

    visit root_path
    within('#sidebar') do
      click_on 'Orçamentos'
    end

    search_field = find_by_id('q')
    search_field.set('AS4D7FDR7R5R54T')
    click_on 'Pesquisar'

    within('table') do
      expect(page).to have_content 'AS4D7FDR7R5R54T'
      expect(page).to have_content 'Fernando Paulo'
      expect(page).to have_content 'João Guilhermo'
    end

    search_field = find_by_id('q')
    search_field.set('XYZ23FGTR56YU99')
    click_on 'Pesquisar'

    within('table') do
      expect(page).not_to have_content 'XYZ23FGTR56YU99'
      expect(page).not_to have_content 'João Pessoa'
      expect(page).not_to have_content 'Guilhermo Urquiola'
    end
    
  end
end
