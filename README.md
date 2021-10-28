<h1 style="color:#2C3E50"> Frank Calendar</h1>

<h3 align="justify">Software de calendário para gerenciar eventos, desenvolvido em Sinatra.</h3>

<h2> Principais tecnologias utilizadas: </h2>
<p>
&#10003; Ruby 
&#10003; Sinatra 
&#10003; Webrick
&#10003; Postgres
&#10003; Rspec
&#10003; Rubocop
&#10003; Simplecov
</p>

<br>
<h2> Executando o projeto: </h2>
<br>

<p>
  &#10071; Para executar o projeto é necessario ter instalado na sua maquina o Docker + Docker compose.
</p>
<p>
  Caso necessario, documentação oficial <a href="https://www.docker.com/get-started">aqui</a>
</p>

<br>

Para executar o projeto, abra o terminal(ctl+alt+t) e clone o projeto:
```
git clone git@git.campuscode.com.br:onboarding2021setembro/frank_calendar.git

```

Entre na pasta:
```
cd frank_calendar
```

Execute o comando para criar o container com Docker:
```
docker-compose build

```

Faça uma copia das variáveis de ambiente:
```
cp .env{.sample,}

```

Suba o container com o comando:
```
docker-compose up -d
```

Execute o comando para criar banco e seeds:
```
bin/setup

```

Para acessar a aplicação, abra no navegador:
```
http://127.0.0.1:4567/
```
<br>

*Caso queira efetuar testes com RSPEC e verificar cobertura, execute os comandos abaixo:*
```
- Para entrar no bash do container web:
docker-compose exec web bash

- Digite o comando:
rspec

```

*Caso queira verificar a formatacao e sintaxe do codigo com Rubocop, execute os comandos abaixo:*
```
- Para entrar no bash do container web:
docker-compose exec web bash

- Digite o comando:
rubocop

```

*Caso queira visualizar as informações de banco/seeds, execute os comandos abaixo:*
```
- Para entrar no bash do container de banco de dados(no caso db):
docker-compose exec db bash

- Para entrar no terminal do Postgres:
psql -U postgres

- Para entrar no banco(no caso, banco de desenvolvimento):
\c frankcalendar_development

- Para ver informacoes das tabelas:
\d

- Para acessar as colunas de uma tabela(no caso users):
\d users

```

<br>
<h2 > Dados de API: </h2>
<br>

<p >⌛ Em desenvolvimento...</p>
<br>

<h3 style="color:#2C3E50"> Endpoint para visualizar todos os usuários:</h3>

```
Rota: GET http://127.0.0.1:4567/users

Output:

[
  {
    "id": "1",
    "name": "Maria",
    "email": "maria@frankcalendar.com",
    "created_at": "2021-10-25",
    "updated_at": "2021-10-25"
  },
  {
    "id": "2",
    "name": "Joao",
    "email": "joao@frankcalendar.com",
    "created_at": "2021-10-25",
    "updated_at": "2021-10-25"
  },
  {
    "id": "3",
    "name": "Ana",
    "email": "ana@frankcalendar.com",
    "created_at": "2021-10-25",
    "updated_at": "2021-10-25"
  }
]

Output caso nao existam usuários criados:

{
  "message": "Nenhum usuário criado!"
}
```

<h3 style="color:#2C3E50"> Endpoint para adicionar usuário: </h3>

```
Rota:  POST http://127.0.0.1:4567/users

Input:

{
  "name": "ana",
  "email": "ana@frankcalendar.com"
}

Output em caso de sucesso:

{
  "name": "ana",
  "email": "ana@frankcalendar.com"
}

Output em caso de falha(campos em branco):

[
  "name: não pode ficar em branco!",
  "email: não pode ficar em branco!"
]

Output em caso de falha(faltando campos):

[
  "name: campo faltando!",
  "email: campo faltando!"
]

Output em caso de falha(email inválido):

[
  "Email inválido!"
]