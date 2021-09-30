<h1> Frank Calendar</h1>

<h3 align="justify">Software de calendário para gerenciar eventos, desenvolvido em Sinatra.</h3>

<h2> Principais tecnologias utilizadas: </h2>
<p>
&#10003; Ruby 
&#10003; Sinatra 
&#10003; Webrick
&#10003; Postgres
&#10003; Rspec
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
docker build --tag frank_calendar .

```

Suba o container com o comando:
```
docker-compose up -d
```

Execute o comando para criar banco e seeds:
```
ruby bin/setup.rb

```

Para acessar a aplicação, abra no navegador:
```
http://127.0.0.1:4567/
```
<br>

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
