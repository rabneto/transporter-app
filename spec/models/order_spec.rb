require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when distance is empty' do
        o = Order.new(distance: '',
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
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when product_id is empty' do
        o = Order.new(distance: 25,
                          product_id: '',
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
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when product_width is empty' do
        o = Order.new(distance: 25,
                          product_id: 'tv 41 polegadas',
                          product_width: '',
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
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when product_height is empty' do
        o = Order.new(distance: 25,
                          product_id: 'tv 41 polegadas',
                          product_width: 120,
                          product_height: '',
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
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when product_depth is empty' do
        o = Order.new(distance: 25,
                          product_id: 'tv 41 polegadas',
                          product_width: 120,
                          product_height: 80,
                          product_depth: '',
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
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when product_weight is empty' do
        o = Order.new(distance: 25,
                          product_id: 'tv 41 polegadas',
                          product_width: 120,
                          product_height: 80,
                          product_depth: 20,
                          product_weight: '',
                          origin_address: 'Avenida B, 123',
                          origin_city: 'Guarulhos',
                          origin_uf: 'SP',
                          destiny_address: 'Av. Paulisa, 234 - Sala 605',
                          destiny_city: 'São Paulo',
                          destiny_uf: 'SP',
                          sender_name: 'Fernando Paulo',
                          sender_document: '12345678978',
                          sender_phone: '(11) 99877-4455',
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when origin_address is empty' do
        o = Order.new(distance: 25,
                          product_id: 'tv 41 polegadas',
                          product_width: 120,
                          product_height: 80,
                          product_depth: 20,
                          product_weight: 3000,
                          origin_address: '',
                          origin_city: 'Guarulhos',
                          origin_uf: 'SP',
                          destiny_address: 'Av. Paulisa, 234 - Sala 605',
                          destiny_city: 'São Paulo',
                          destiny_uf: 'SP',
                          sender_name: 'Fernando Paulo',
                          sender_document: '12345678978',
                          sender_phone: '(11) 99877-4455',
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when origin_city is empty' do
        o = Order.new(distance: 25,
                          product_id: 'tv 41 polegadas',
                          product_width: 120,
                          product_height: 80,
                          product_depth: 20,
                          product_weight: 3000,
                          origin_address: 'Avenida B, 123',
                          origin_city: '',
                          origin_uf: 'SP',
                          destiny_address: 'Av. Paulisa, 234 - Sala 605',
                          destiny_city: 'São Paulo',
                          destiny_uf: 'SP',
                          sender_name: 'Fernando Paulo',
                          sender_document: '12345678978',
                          sender_phone: '(11) 99877-4455',
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when origin_uf is empty' do
        o = Order.new(distance: 25,
                          product_id: 'tv 41 polegadas',
                          product_width: 120,
                          product_height: 80,
                          product_depth: 20,
                          product_weight: 3000,
                          origin_address: 'Avenida B, 123',
                          origin_city: 'Guarulhos',
                          origin_uf: '',
                          destiny_address: 'Av. Paulisa, 234 - Sala 605',
                          destiny_city: 'São Paulo',
                          destiny_uf: 'SP',
                          sender_name: 'Fernando Paulo',
                          sender_document: '12345678978',
                          sender_phone: '(11) 99877-4455',
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when destiny_address is empty' do
        o = Order.new(distance: 25,
                          product_id: 'tv 41 polegadas',
                          product_width: 120,
                          product_height: 80,
                          product_depth: 20,
                          product_weight: 3000,
                          origin_address: 'Avenida B, 123',
                          origin_city: 'Guarulhos',
                          origin_uf: 'SP',
                          destiny_address: '',
                          destiny_city: 'São Paulo',
                          destiny_uf: 'SP',
                          sender_name: 'Fernando Paulo',
                          sender_document: '12345678978',
                          sender_phone: '(11) 99877-4455',
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when destiby_city is empty' do
        o = Order.new(distance: 25,
                          product_id: 'tv 41 polegadas',
                          product_width: 120,
                          product_height: 80,
                          product_depth: 20,
                          product_weight: 3000,
                          origin_address: 'Avenida B, 123',
                          origin_city: 'Guarulhos',
                          origin_uf: 'SP',
                          destiny_address: 'Av. Paulisa, 234 - Sala 605',
                          destiny_city: '',
                          destiny_uf: 'SP',
                          sender_name: 'Fernando Paulo',
                          sender_document: '12345678978',
                          sender_phone: '(11) 99877-4455',
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when destiny_uf is empty' do
        o = Order.new(distance: 25,
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
                          destiny_uf: '',
                          sender_name: 'Fernando Paulo',
                          sender_document: '12345678978',
                          sender_phone: '(11) 99877-4455',
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when sender_name is empty' do
        o = Order.new(distance: 25,
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
                          sender_name: '',
                          sender_document: '12345678978',
                          sender_phone: '(11) 99877-4455',
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when sender_document is empty' do
        o = Order.new(distance: 25,
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
                          sender_document: '',
                          sender_phone: '(11) 99877-4455',
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when sender_phone is empty' do
        o = Order.new(distance: 25,
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
                          sender_phone: '',
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when recipient_name is empty' do
        o = Order.new(distance: 25,
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
                          recipient_name: '',
                          recipient_document: '78945678945',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when recipient_document is empty' do
        o = Order.new(distance: 25,
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
                          recipient_name: 'João Guilhermo',
                          recipient_document: '',
                          recipient_phone: '(11) 98865-7854')
        result = o.valid?
        expect(result).to eq false
      end
      it 'false when recipient_phone is empty' do
        o = Order.new(distance: 25,
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
                          recipient_name: 'João Guilhermo',
                          recipient_document: '78945678945',
                          recipient_phone: '')
        result = o.valid?
        expect(result).to eq false
      end
    end
  end
end
