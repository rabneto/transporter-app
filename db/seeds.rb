puts 'populating transport modes ...'

tm1 = TransportMode.create!(name: 'Entrega Expressa', min_range: 1, max_range: 10, min_weight: 1, max_weight: 10,
                            tax: 55)
tm2 = TransportMode.create!(name: 'Entrega Bairros', min_range: 1, max_range: 25, min_weight: 1, max_weight: 20,
                            tax: 65)
tm3 = TransportMode.create!(name: 'Entrega Bairros Expressa', min_range: 5, max_range: 30, min_weight: 10,
                            max_weight: 120, tax: 80)
tm4 = TransportMode.create!(name: 'Entrega Intermunicipal', min_range: 50, max_range: 500, min_weight: 10,
                            max_weight: 50, tax: 100)
tm5 = TransportMode.create!(name: 'Entrega Intermunicipal Expressa', min_range: 50, max_range: 500, min_weight: 5,
                            max_weight: 70, tax: 120)
tm6 = TransportMode.create!(name: 'Entrega Interestadual', min_range: 100, max_range: 800, min_weight: 10,
                            max_weight: 100, tax: 180)

puts 'populating prices ...'

Price.create!(min_weight: 1, max_weight: 2, km_price: 0.8, transport_mode: tm1)
Price.create!(min_weight: 3, max_weight: 4, km_price: 0.7, transport_mode: tm1)
Price.create!(min_weight: 5, max_weight: 10, km_price: 0.6, transport_mode: tm1)
Price.create!(min_weight: 7, max_weight: 8, km_price: 0.55, transport_mode: tm1)
Price.create!(min_weight: 9, max_weight: 10, km_price: 0.50, transport_mode: tm1)

Price.create!(min_weight: 1, max_weight: 5, km_price: 0.65, transport_mode: tm2)
Price.create!(min_weight: 6, max_weight: 10, km_price: 0.55, transport_mode: tm2)
Price.create!(min_weight: 11, max_weight: 15, km_price: 0.50, transport_mode: tm2)
Price.create!(min_weight: 16, max_weight: 20, km_price: 0.45, transport_mode: tm2)

Price.create!(min_weight: 10, max_weight: 15, km_price: 80, transport_mode: tm3)
Price.create!(min_weight: 16, max_weight: 20, km_price: 80, transport_mode: tm3)
Price.create!(min_weight: 21, max_weight: 40, km_price: 80, transport_mode: tm3)
Price.create!(min_weight: 41, max_weight: 80, km_price: 80, transport_mode: tm3)
Price.create!(min_weight: 81, max_weight: 120, km_price: 80, transport_mode: tm3)

Price.create!(min_weight: 5, max_weight: 10, km_price: 1.25, transport_mode: tm5)

puts 'populating deadlines ...'

Deadline.create!(min_range: 1, max_range: 5, hours: 4, transport_mode: tm1)
Deadline.create!(min_range: 6, max_range: 10, hours: 6, transport_mode: tm1)

Deadline.create!(min_range: 1, max_range: 10, hours: 8, transport_mode: tm2)
Deadline.create!(min_range: 11, max_range: 20, hours: 12, transport_mode: tm2)
Deadline.create!(min_range: 21, max_range: 25, hours: 24, transport_mode: tm2)

Deadline.create!(min_range: 5, max_range: 10, hours: 6, transport_mode: tm3)
Deadline.create!(min_range: 11, max_range: 20, hours: 12, transport_mode: tm3)
Deadline.create!(min_range: 21, max_range: 30, hours: 24, transport_mode: tm3)

puts 'populating categories ...'

c1 = Category.create!(name: 'Bicicleta')
c2 = Category.create!(name: 'Moto')
c3 = Category.create!(name: 'Carro')
Category.create!(name: 'VLC')
Category.create!(name: 'Caminhão')
Category.create!(name: 'Utilitário Leve')

puts 'populating vehicles ...'

Vehicle.create!(category: c3, plate: 'EUW-2389', brand: 'FIAT', model: 'Ducato', year: 2019, max_weight: 35)
Vehicle.create!(category: c2, plate: 'PTT-3679', brand: 'Honda', model: 'Cargo', year: 2017, max_weight: 50)
Vehicle.create!(category: c1, plate: 'INT-0001', brand: 'Monark', model: 'Monareta', year: 1985, max_weight: 5)
Vehicle.create!(category: c2, plate: 'JTT-5825', brand: 'Honda', model: 'Pop', year: 2018, max_weight: 15)

puts 'two order pendent ...'

Order.create!(start: '', deadline: '', delivered: '', delay_reason: '', distance: 25, product_id: 'tv 41 polegadas', product_width: 120,
              product_height: 80, product_depth: 20, product_weight: 3000, origin_address: 'Avenida B, 123', origin_city: 'Guarulhos',
              origin_uf: 'SP', destiny_address: 'Av. Paulisa, 234 - Sala 605', destiny_city: 'São Paulo', destiny_uf: 'SP', sender_name: 'Fernando Paulo',
              sender_document: '12345678978', sender_phone: '(11) 99877-4455', sender_email: '', recipient_name: 'João Guilhermo',
              recipient_document: '78945678945', recipient_email: '', recipient_phone: '(11) 98865-7854', transport_mode_id: nil,
              vehicle_id: nil, price: '')

Order.create!(start: '', deadline: '', delivered: '', delay_reason: '', distance: 10, product_id: 'Cadeira Gamer FOXX', product_width: 60,
              product_height: 150, product_depth: 40, product_weight: 5, origin_address: 'Avenida Nazaré, 1278', origin_city: 'Belém',
              origin_uf: 'PA', destiny_address: 'Av. WE 18, SN 14, N° 578', destiny_city: 'Ananindeua', destiny_uf: 'PA', sender_name: 'Vitor Pereira Lemos',
              sender_document: '07535894600', sender_phone: '(91) 98525-7319', sender_email: 'vitor.plemos@hotmail.com', recipient_name: 'Patrícia Alvez Dias',
              recipient_document: '85974541203', recipient_email: '', recipient_phone: '(91) 99977-7514', transport_mode_id: nil,
              vehicle_id: nil, price: '')


