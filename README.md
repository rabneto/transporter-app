<img src="https://img.shields.io/badge/ruby-3.1.2p20-blue"/>
<img src="https://img.shields.io/badge/rails-7.0.4-blue"/>
<img src="https://img.shields.io/badge/tests-155%20passed-green"/>

# Transporter APP

Aplicação desenvolvida em Ruby on Rails, para administração de transportadoras

### Tabela de Conteúdos
   * [Versões de desenvolvimento](#versões-de-desenvolvimento)
   * [Executando testes](#executando-testes)
   * [Como rodas a aplicação](#como-rodar-a-aplicação)
   * [Status atual das tarefas](#status-atual-das-tarefas)

## 🚀 Começando

Essas instruções permitirão que você obtenha uma cópia do projeto em operação na sua máquina local para fins de desenvolvimento e teste.

### 📋 Versões de desenvolvimento

* Ruby 3.1.2p20
* Rails 7.0.4

### ⚙️ Executando os testes

executar o comando `rails generate rspec:install` após o bundle inicial e `rspec`para rodar os testes

### Como rodar a aplicação

No terminal rode o comando

`git clone https://git-qsd.campuscode.com.br/rabneto/transporter-app.git`

Entre na pasta do projeto

`cd transporter-app`

Instale as dependências

`bundle install`

Rodar as migtrations

`rails db:migrate`

Importe os dados

`rails db:setup`

Execute a aplicação

`rails server`

Pronto! Agora você pode rodar a aplicação na sua máquina a partir da rota http://localhost:3000

### Status atual das tarefas

- [X] CADASTRO DE MODALIDADE DE TRANSPORTE
- [X] CONSULTA DE MODALIDADE DE TRANSPORTE
- [X] CONSULTA DE VEÍCULOS
- [X] CADASTRO DE VEÍCULOS
- [X] CONFIGURAÇÃO DE PREÇOS POR PESO
- [X] CONFIGURAÇÕES DE PRAZO
- [X] CRIAR ORDEM DE ENTREGA
- [X] CONSULTA DE ORÇAMENTOS
- [X] INICIAR ORDEM DE ENTREGA
- [X] ENCERRAR ORDEM DE ENTREGA
- [X] CONSULTA DE ENTREGA