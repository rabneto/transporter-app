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
* banco Sqlite
* rspec
* capybara

### ⚙️ Executando os testes

executar o comando `rails generate rspec:install` após o bundle inicial e `rspec`para rodar os testes

### Como rodar a aplicação

No terminal rode o comando

`git clone https://git-qsd.campuscode.com.br/rabneto/transporter-app.git`

Entre na pasta do projeto

`cd transporter-app`

Instale as dependências

`bundle install`

Execute a aplicação

`rails server`

Pronto! Agora você pode rodar a aplicação na sua máquina a partir da rota http://localhost:3000

### Status atual das tarefas

- [X] CADASTRO DE MODALIDADE DE TRANSPORTE
- [X] CONSULTA DE MODALIDADE DE TRANSPORTE
- [ ] CONSULTA DE VEÍCULOS
- [ ] CADASTRO DE VEÍCULOS
- [ ] CONFIGURAÇÃO DE PREÇOS POR PESO
- [ ] CONFIGURAÇÕES DE PRAZO
- [ ] CRIAR ORDEM DE ENTREGA
- [ ] CONSULTA DE ORÇAMENTOS
- [ ] INICIAR ORDEM DE ENTREGA
- [ ] ENCERRAR ORDEM DE ENTREGA
- [ ] CONSULTA DE ENTREGA