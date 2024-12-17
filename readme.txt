# Projeto Mudanças

Este projeto envolve o uso de um banco de dados PostgreSQL e um ambiente Python para gerenciar operações relacionadas a mudanças.

## Pré-requisitos

Antes de rodar o projeto, certifique-se de que você tenha o seguinte instalado:

- Python 3.x
- PostgreSQL
- `pip` (para instalar dependências Python)

## Passos para execução

### 1. Instalar as dependências Python

Clone o repositório e instale as dependências necessárias para o projeto usando o `pip`:

pip install -r requirements.txt

### 2. Criar o banco de dados PostgreSQL

Após instalar as dependências, crie o banco de dados no PostgreSQL. Utilize o seguinte comando para criar o banco de dados chamado `mudancas`:

createdb -U postgres -h localhost -p 5432 mudancas

### 3. Executar os scripts SQL

Após criar o banco de dados, execute os scripts SQL na pasta `migrations` para configurar o banco e suas tabelas, e na pasta `migrations/seeds` para inserir dados iniciais.

Execute os scripts dentro de `migrations`:

psql -U postgres -h localhost -p 5432 -d mudancas -f migrations/0001_initial_schema.sql
psql -U postgres -h localhost -p 5432 -d mudancas -f migrations/0002_trigger.sql
# E assim por diante, para todos os scripts em migrations

Execute os scripts dentro de `migrations/seeds` para popular o banco de dados com dados iniciais:

psql -U postgres -h localhost -p 5432 -d mudancas -f migrations/seeds/0001_inital_data.sql

### 4. Configurar as variáveis do banco de dados no arquivo `config.py`

Abra o arquivo `config.py` e adicione as configurações do banco de dados criado, substituindo os valores pelos apropriados para o seu ambiente:


DB_NAME = "mudancas"
DB_USER = "postgres"
DB_PASSWORD = "postgres"
DB_HOST = "localhost"
DB_PORT = "5432"

### 5. Rodar o projeto

python main.py
