require 'rails_helper'

describe 'usuário acessa o rastreamento' do
  it 'e vê o formulário de rastreamento' do
    visit new_user_session_path

    click_on 'Rastrear Entrega'

    expect(current_path).to eq search_path
  end

  it 'e pesquisa por uma ordem de entrega pendente' do
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

    visit new_user_session_path

    click_on 'Rastrear Entrega'

    search_field = find_by_id('code')
    search_field.set('WSL4D8FER4R87R9')
    click_on 'Pesquisar'

    within('h1') do
      expect(page).to have_content 'WSL4D8FER4R87R9'
    end

    expect(page).to have_css('#bt-pendent.inner-circle-active')

    expect(page).to have_content 'Ordem de entrega aberta'
    expect(page).to have_content 'Endereço de saída'
    expect(page).to have_content 'Endereço de entrega'

    expect(page).to have_content 'Avenida B, 123. Guarulhos/SP'
    expect(page).to have_content 'Av. Paulisa, 234 - Sala 605. São Paulo/SP'
  end

  it 'e pesquisa por uma ordem de entrega que já saiu para entrega' do
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('XYZ23FGTR56YU99')

    tm = TransportMode.create!(name: 'Express',
                               min_range: 1,
                               max_range: 30,
                               min_weight: 1,
                               max_weight: 15,
                               tax: 200)

    Price.create!(min_weight: 1, max_weight: 10, km_price: 2, transport_mode: tm)
    Deadline.create!(min_range: 1, max_range: 30, hours: 12, transport_mode: tm)

    c = Category.create!(name: 'Moto')

    v = Vehicle.create!(category: c,
                        plate: 'GTY-7532',
                        brand: 'Honda',
                        model: 'Pop',
                        year: 2018,
                        max_weight: 10)

    o = Order.create!(start: DateTime.now - 10,
                      deadline: DateTime.now + 2,
                      delivered: '',
                      delay_reason: '',
                      distance: 25,
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
                      sender_name: 'João Pessoa',
                      sender_document: '12345678978',
                      sender_phone: '(11) 99877-4455',
                      sender_email: '',
                      recipient_name: 'Guilhermo Urquiola',
                      recipient_document: '78945678945',
                      recipient_email: '',
                      recipient_phone: '(11) 98865-7854',
                      transport_mode_id: tm.id,
                      vehicle_id: v.id,
                      tax: 200,
                      km_price: 2,
                      price: 250,
                      status: 2)

    visit new_user_session_path

    click_on 'Rastrear Entrega'

    search_field = find_by_id('code')
    search_field.set('XYZ23FGTR56YU99')
    click_on 'Pesquisar'

    within('h1') do
      expect(page).to have_content 'XYZ23FGTR56YU99'
    end

    expect(page).to have_css('#bt-in-delivery.inner-circle-active')
    expect(page).to have_css('#bt-pendent.inner-circle-active')

    expect(page).to have_content 'Previsão de entrega'
    expect(page).to have_content 'Saiu para entrega'
    expect(page).to have_content 'Ordem de entrega aberta'
    
    expect(page).to have_content 'Endereço de saída'
    expect(page).to have_content 'Endereço de entrega'

    expect(page).to have_content 'Avenida B, 123. Guarulhos/SP'
    expect(page).to have_content 'Av. Paulisa, 234 - Sala 605. São Paulo/SP'
  end

  it 'e pesquisa por uma ordem de entrega entregue' do
    allow(SecureRandom).to receive(:alphanumeric).with(15).and_return('XYZ23FGTR56YU99')

    tm = TransportMode.create!(name: 'Express',
                               min_range: 1,
                               max_range: 30,
                               min_weight: 1,
                               max_weight: 15,
                               tax: 200)

    Price.create!(min_weight: 1, max_weight: 10, km_price: 2, transport_mode: tm)
    Deadline.create!(min_range: 1, max_range: 30, hours: 12, transport_mode: tm)

    c = Category.create!(name: 'Moto')

    v = Vehicle.create!(category: c,
                        plate: 'GTY-7532',
                        brand: 'Honda',
                        model: 'Pop',
                        year: 2018,
                        max_weight: 10)

    o = Order.create!(start: DateTime.now - 10,
                      deadline: DateTime.now + 2,
                      delivered: DateTime.now - 1,
                      delay_reason: '',
                      distance: 25,
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
                      sender_name: 'João Pessoa',
                      sender_document: '12345678978',
                      sender_phone: '(11) 99877-4455',
                      sender_email: '',
                      recipient_name: 'Guilhermo Urquiola',
                      recipient_document: '78945678945',
                      recipient_email: '',
                      recipient_phone: '(11) 98865-7854',
                      transport_mode_id: tm.id,
                      vehicle_id: v.id,
                      tax: 200,
                      km_price: 2,
                      price: 250,
                      status: 3)

    visit new_user_session_path

    click_on 'Rastrear Entrega'

    search_field = find_by_id('code')
    search_field.set('XYZ23FGTR56YU99')
    click_on 'Pesquisar'

    within('h1') do
      expect(page).to have_content 'XYZ23FGTR56YU99'
    end

    expect(page).to have_css('#bt-delivered.inner-circle-active')
    expect(page).to have_css('#bt-in-delivery.inner-circle-active')
    expect(page).to have_css('#bt-pendent.inner-circle-active')

    expect(page).to have_content 'Entregue ao destinatário'
    expect(page).to have_content 'Previsão de entrega'
    expect(page).to have_content 'Saiu para entrega'
    expect(page).to have_content 'Ordem de entrega aberta'

    expect(page).to have_content 'Endereço de saída'
    expect(page).to have_content 'Endereço de entrega'

    expect(page).to have_content 'Avenida B, 123. Guarulhos/SP'
    expect(page).to have_content 'Av. Paulisa, 234 - Sala 605. São Paulo/SP'
  end

  it 'e pesquisa por uma ordem de entrega inexistente' do
    visit new_user_session_path

    click_on 'Rastrear Entrega'

    search_field = find_by_id('code')
    search_field.set('Q7W7FD789SD89S9')
    click_on 'Pesquisar'

    within('div#alert') do
      expect(page).to have_content 'Nenhuma ordem de entrega encontrada para este código.'
    end
  end
end
