<h1 style="color:#2C3E50"> Frank Calendar</h1>

<h2 align="justify">Software de calendário para gerenciar eventos, desenvolvido em Sinatra.</h2>

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
git clone git@github.com:faalbuquerque/frank_calendar.git

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

<h2 style="color:#2C3E50"> Endpoint para visualizar todos os usuários:</h2>

```json
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


<h2 style="color:#2C3E50"> Endpoint para visualizar um usuário:</h2>

```json
Rota: GET http://127.0.0.1:4567/users/:id

Output:

[
  {
    "id": "3",
    "name": "Ana",
    "email": "ana@frankcalendar.com",
    "created_at": "2021-11-17",
    "updated_at": "2021-11-17",
    "password": "FILTERED",
    "created_at": "2021-11-18T11:40:57-03:00",
    "updated_at": "2021-11-18T11:40:57-03:00"
  }
]

Output caso nao exista um usuario com o id informado:

{
  "message": "Nenhum usuário encontrado!"
}
```


<h2 style="color:#2C3E50"> Endpoint para adicionar usuário: </h2>

```json
Rota:  POST http://127.0.0.1:4567/users

Input:

{
  "name": "ana",
  "email": "ana@frankcalendar.com",
  "password": "123456"
}

Output em caso de sucesso:

{
  "name": "ana",
  "email": "ana@frankcalendar.com",
  "password": "FILTERED"
}

Output em caso de falha(campos em branco):

[
  "name: não pode ficar em branco!",
  "email: não pode ficar em branco!"
  "Não foi possível salvar!"
]

Output em caso de falha(faltando campos):

[
  "name: campo faltando!",
  "email: campo faltando!"
  "Não foi possível salvar!"
]

Output em caso de falha(email inválido):

[
  "Este email já foi utilizado!",
  "Não foi possível salvar!"
]
```

<h2 style="color:#2C3E50"> Endpoint para alterar usuário: </h2>

```json
Rota:  PATCH http://127.0.0.1:4567/users/:id

Input:

{
  "name": "ana",
  "email": "ana@frankcalendar.com",
  "password": "123456"
}

Output em caso de sucesso:

{
  "name": "ana",
  "email": "ana@frankcalendar.com",
  "password": "FILTERED"
  "message": "Usuário atualizado!"
}

Output em caso de falha(dados inválidos):

{
  "message": "Não foi possivel atualizar!"
}

```


<br>
<h1 > Autenticação de usuario pela API: </h1>
<br>

```json
Rota:  POST http://127.0.0.1:4567/users/login

Input:

{
	"email": "maria@frankcalendar.com",
	"password": "123456"
}

Output em caso de sucesso:

{
  "id": "1",
  "name": "Maria",
  "email": "maria@frankcalendar.com",
  "created_at": "2021-11-17",
  "updated_at": "2021-11-17",
  "token": "bcdb263b-6ed0-49c1-bc39-1d69d7a78727",
  "password": "FILTERED",
  "message": "Usuario autenticado com sucesso!"
}

Output em caso de falha(campos em branco, faltando campos ou senha incorreta):

{
  "message": "Erro de autenticação!"
}

```

---
<br>

<h2 style="color:#2C3E50"> Endpoint para usuário adicionar eventos: </h2>

```json
Rota:  POST http://127.0.0.1:4567/users/:id/events

Input:

{ 
	"event_name": "Um event",
	"event_location": "On line, link aqui", 
	"event_description": "Um evento legal",
  "start_date": "2021-12-01",
	"end_date": "2021-12-02",
	"user_id": "3",
}

Output em caso de sucesso:

{
  "event_name": "a event",
  "event_location": "On line, link aqui",
  "event_description": "Um evento legal",
  "start_date": "2021-12-01",
  "end_date": "2021-12-02",
  "user_id": "3",
  "message": "Evento criado com sucesso!"
}

Output em caso de falha(campos em branco):

[
  "event_name: não pode ficar em branco!",
  "event_location: não pode ficar em branco!",
  "event_description: não pode ficar em branco!",
  "start_date: não pode ficar em branco!",
  "end_date: não pode ficar em branco!",
  "Não foi possivel criar evento!"
]

Output em caso de falha(faltando campos):

[
  "event_name: campo faltando!",
  "event_location: campo faltando!",
  "event_description: campo faltando!",
  "start_date: campo faltando!",
  "end_date: campo faltando!",
  "Não foi possivel criar evento!"
]

Output em caso de falha(tentar criar evento sem estar logado):

{
  "message": "Faça login para criar eventos!"
}

Output em caso de falha(tentar criar evento como outro usuario(outro id)):

{
  "message": "Algo deu errado!"
}

```

<h2 style="color:#2C3E50"> Endpoint para visualizar eventos de um usuário: </h2>

```json
Rota:  GET http://127.0.0.1:4567/users/:id/events


Output em caso de sucesso:

[
  {
    "id": "1",
    "event_name": "a event",
    "event_location": "On line, link aqui",
    "event_description": "Um evento legal",
    "start_date": "2021-12-01 00:00:00-03",
    "end_date": "2021-12-02 00:00:00-03",
    "user_id": "3"
  },
  {
    "id": "2",
    "event_name": "b event",
    "event_location": "On line, link aqui",
    "event_description": "Um evento legal",
    "start_date": "2021-12-01 00:00:00-03",
    "end_date": "2021-12-02 00:00:00-03",
    "user_id": "3"
  },
  {
    "id": "3",
    "event_name": "c event",
    "event_location": "On line, link aqui",
    "event_description": "Um evento legal",
    "start_date": "2021-12-01 00:00:00-03",
    "end_date": "2021-12-02 00:00:00-03",
    "user_id": "3"
  }
]

Output em caso de falha(tentar visualizar eventos sem estar logado):

{
  "message": "Faça login para ver seus eventos!"
}


Output caso ainda não existam eventos:

{
  "message": "Nenhum evento cadastrado!"
}

```
