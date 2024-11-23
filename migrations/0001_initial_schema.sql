-- Tabela Cidade
CREATE TABLE Cidade (
id INT PRIMARY KEY,
nome_cidade VARCHAR(100) UNIQUE,
estado VARCHAR(50)
);

-- Tabela Endereco
CREATE TABLE Endereco (
id INT PRIMARY KEY,
rua VARCHAR(100),
numero INT,
complemento VARCHAR(50),
cep VARCHAR(20),
id_cidade INT,
FOREIGN KEY (id_cidade) REFERENCES Cidade(id)
);

-- Tabela Empresa_de_Mudancas
CREATE TABLE Empresa_de_Mudancas (
id INT PRIMARY KEY,
nome VARCHAR(100) UNIQUE,
telefones VARCHAR(50),
id_endereco INT,
FOREIGN KEY (id_endereco) REFERENCES Endereco(id)
);

-- Tabela Servico
CREATE TABLE Servico (
id INT PRIMARY KEY,
nome_servico VARCHAR(100) UNIQUE,
tipo_servico VARCHAR(50)
);

-- Tabela Cliente
CREATE TABLE Cliente (
id INT PRIMARY KEY,
codigo_cliente INT UNIQUE,
cpf VARCHAR(11) UNIQUE,
rg VARCHAR(15),
nome_completo VARCHAR(100),
telefone VARCHAR(15),
id_endereco INT,
FOREIGN KEY (id_endereco) REFERENCES Endereco(id)
);

-- Tabela Funcionario
CREATE TABLE Funcionario (
id INT PRIMARY KEY,
cpf_funcionario VARCHAR(11) UNIQUE,
rg_funcionario VARCHAR(15),
nome_completo VARCHAR(100),
telefone_contato VARCHAR(15),
tipo_funcionario VARCHAR(50),
salario FLOAT,
id_endereco INT,
id_empresa INT,
FOREIGN KEY (id_endereco) REFERENCES Endereco(id),
FOREIGN KEY (id_empresa) REFERENCES Empresa_de_Mudancas(id)
);

-- Tabela Empresa_Servico_Cidade (tabela de junção entre Empresa_de_Mudancas, Servico e Cidade)
CREATE TABLE Empresa_Servico_Cidade (
id INT PRIMARY KEY,
id_empresa INT,
id_servico INT,
id_cidade INT,
preco_hora FLOAT,
taxa_excedente FLOAT,
FOREIGN KEY (id_empresa) REFERENCES Empresa_de_Mudancas(id),
FOREIGN KEY (id_servico) REFERENCES Servico(id),
FOREIGN KEY (id_cidade) REFERENCES Cidade(id)
);

-- Tabela Pedido
CREATE TABLE Pedido (
id INT PRIMARY KEY,
codigo_pedido INT UNIQUE,
data_solicitacao DATE,
data_resolucao DATE,
preco_total FLOAT,
status VARCHAR(50),
id_endereco_partida INT,
id_endereco_destino INT,
data_efetiva DATE,
id_cliente INT,
FOREIGN KEY (id_endereco_partida) REFERENCES Endereco(id),
FOREIGN KEY (id_endereco_destino) REFERENCES Endereco(id),
FOREIGN KEY (id_cliente) REFERENCES Cliente(id)
);

-- Tabela Pedido_Servico (tabela de junção entre Pedido e Empresa_Servico_Cidade)
CREATE TABLE Pedido_Servico (
id INT PRIMARY KEY,
id_pedido INT,
id_empresa_servico_cidade INT,
tempo_execucao TIME,
FOREIGN KEY (id_pedido) REFERENCES Pedido(id),
FOREIGN KEY (id_empresa_servico_cidade) REFERENCES Empresa_Servico_Cidade(id)
);

-- Tabela Pedido_Servico_Funcionario (relacionamento entre Pedido_Servico e Funcionario)
CREATE TABLE Pedido_Servico_Funcionario (
id INT PRIMARY KEY,
id_pedido_servico INT,
id_funcionario INT,
FOREIGN KEY (id_pedido_servico) REFERENCES Pedido_Servico(id),
FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id)
);
