require 'rails_helper'

describe 'usuário edita uma ordem de serviço' do
  it 'a partir da home' do

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

    expect(page).to have_content 'Editar Ordem de Entrega'
    
    fill_in('Identificação do Produto', with: 'tv 41 polegadas')
    fill_in('Peso do Produto', with: '3000')
    fill_in('Largura do Produto', with: '120')
    fill_in('Altura do Produto', with: '80')
    fill_in('Comprimento do Produto', with: '20')

    fill_in('Endereço de Origem', with: 'Avenida B, 123')
    fill_in('Cidade de Origem', with: 'Guarulhos')
    fill_in('UF de Origem', with: 'SP')
    fill_in('Endereço de Destino', with: 'Av. Paulisa, 234 - Sala 605')
    fill_in('Cidade de Destino', with: 'São Paulo')
    fill_in('UF de Destino', with: 'SP')
    fill_in('Distância', with: '25')

    fill_in('Nome do remetente', with: 'Fernando Paulo')
    fill_in('CPF do remetente', with: '12345678978')
    fill_in('Telefone do remetente', with: '(11) 99877-4455')
    fill_in('E-mail do remetente', with: '')

    fill_in('Nome do destinatário', with: 'João Guilhermo')
    fill_in('CPF do destinatário', with: '78945678945')
    fill_in('Telefone do destinatário', with: '(11) 98865-7854')
    fill_in('E-mail do destinatário', with: '')
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
    click_on 'AS4D7FDR7R5R54T'

    click_on 'Habilitar Edição'

    expect(page).to have_content 'Editar Ordem de Entrega'
    
    fill_in('Identificação do Produto', with: 'TV 41 polegadas')
    fill_in('Peso do Produto', with: '3200')
    fill_in('Largura do Produto', with: '120')
    fill_in('Altura do Produto', with: '80')
    fill_in('Comprimento do Produto', with: '20')

    fill_in('Endereço de Origem', with: 'Avenida B, 123')
    fill_in('Cidade de Origem', with: 'Guarulhos')
    fill_in('UF de Origem', with: 'SP')
    fill_in('Endereço de Destino', with: 'Av. Paulisa, 234 - Sala 605')
    fill_in('Cidade de Destino', with: 'São Paulo')
    fill_in('UF de Destino', with: 'SP')
    fill_in('Distância', with: '25')

    fill_in('Nome do remetente', with: 'Fernando Paulo')
    fill_in('CPF do remetente', with: '12345678978')
    fill_in('Telefone do remetente', with: '(11) 99877-4455')
    fill_in('E-mail do remetente', with: 'fpaulo@globo.com')

    fill_in('Nome do destinatário', with: 'João C. Guilhermo')
    fill_in('CPF do destinatário', with: '78945678945')
    fill_in('Telefone do destinatário', with: '(11) 98865-7854')
    fill_in('E-mail do destinatário', with: 'gui@gmail.com')
    
    click_on 'Salvar'

    within('div#notice') do
      expect(page).to have_content 'Ordem de Entrega atualizada com sucesso.'
    end
    expect(page).to have_field('Identificação do Produto', with: 'TV 41 polegadas')
    expect(page).to have_field('Peso do Produto', with: '3200 kg')
    expect(page).to have_field('Largura do Produto', with: '120 cm')
    expect(page).to have_field('Altura do Produto', with: '80 cm')
    expect(page).to have_field('Comprimento do Produto', with: '20 cm')

    expect(page).to have_field('Endereço de Origem', with: 'Avenida B, 123')
    expect(page).to have_field('Cidade de Origem', with: 'Guarulhos')
    expect(page).to have_field('UF de Origem', with: 'SP')
    expect(page).to have_field('Endereço de Destino', with: 'Av. Paulisa, 234 - Sala 605')
    expect(page).to have_field('Cidade de Destino', with: 'São Paulo')
    expect(page).to have_field('UF de Destino', with: 'SP')
    expect(page).to have_field('Distância', with: '25 km')

    expect(page).to have_field('Nome do remetente', with: 'Fernando Paulo')
    expect(page).to have_field('CPF do remetente', with: '12345678978')
    expect(page).to have_field('Telefone do remetente', with: '(11) 99877-4455')
    expect(page).to have_field('E-mail do remetente', with: 'fpaulo@globo.com')

    expect(page).to have_field('Nome do destinatário', with: 'João C. Guilhermo')
    expect(page).to have_field('CPF do destinatário', with: '78945678945')
    expect(page).to have_field('Telefone do destinatário', with: '(11) 98865-7854')
    expect(page).to have_field('E-mail do destinatário', with: 'gui@gmail.com')
  end

  it 'e mantêm os campos obrigatórios' do

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

    expect(page).to have_content 'Editar Ordem de Entrega'

    fill_in('Identificação do Produto', with: '')
    fill_in('Peso do Produto', with: '')
    fill_in('Largura do Produto', with: '')
    fill_in('Altura do Produto', with: '')
    fill_in('Comprimento do Produto', with: '')

    fill_in('Endereço de Origem', with: '')
    fill_in('Cidade de Origem', with: '')
    fill_in('UF de Origem', with: '')
    fill_in('Endereço de Destino', with: '')
    fill_in('Cidade de Destino', with: '')
    fill_in('UF de Destino', with: '')
    fill_in('Distância', with: '')

    fill_in('Nome do remetente', with: '')
    fill_in('CPF do remetente', with: '')
    fill_in('Telefone do remetente', with: '')
    fill_in('E-mail do remetente', with: '')

    fill_in('Nome do destinatário', with: '')
    fill_in('CPF do destinatário', with: '')
    fill_in('Telefone do destinatário', with: '')
    fill_in('E-mail do destinatário', with: '')

    click_on 'Salvar'

    within('div#alert') do
      expect(page).to have_content 'Não foi possível atualizar a ordem de serviço.'
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

  it 'e não habilita a edição se o status não for pendente' do
    user = User.create!(name: 'Root', email: 'root@gmail.com', password: '123456')
    login_as(user)

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

    visit edit_order_path(o)

    expect(current_path).to eq order_path(o)

    within('div#alert') do
      expect(page).to have_content 'Não é possível editar esta ordem de entrega. Verifique se a mesma já saiu para entrega ou já foi entregue.'
    end

  end

end
