-- Populando a tabela Cidade
INSERT INTO Cidade (id, nome_cidade, estado) VALUES
(1, 'São Paulo', 'SP'),
(2, 'Rio de Janeiro', 'RJ'),
(3, 'Belo Horizonte', 'MG'),
(4, 'Porto Alegre', 'RS'),
(5, 'Curitiba', 'PR'),
(6, 'Salvador', 'BA'),
(7, 'Fortaleza', 'CE'),
(8, 'Recife', 'PE'),
(9, 'Florianópolis', 'SC'),
(10, 'Manaus', 'AM'),
(11, 'Brasília', 'DF'),
(12, 'Belém', 'PA'),
(13, 'Campinas', 'SP'),
(14, 'São Luís', 'MA'),
(15, 'Maceió', 'AL'),
(16, 'Natal', 'RN'),
(17, 'João Pessoa', 'PB'),
(18, 'Aracaju', 'SE'),
(19, 'Cuiabá', 'MT'),
(20, 'Goiânia', 'GO');

-- Populando a tabela Endereco
INSERT INTO Endereco (id, rua, numero, complemento, cep, id_cidade) VALUES
(1, 'Rua das Flores', 123, 'Apto 1', '01000-000', 1),
(2, 'Av. Paulista', 456, NULL, '01310-000', 1),
(3, 'Rua XV de Novembro', 789, NULL, '80020-310', 5),
(4, 'Praia de Copacabana', 101, 'Casa', '22070-000', 2),
(5, 'Av. Beira Mar', 202, 'Apto 502', '60165-121', 7),
(6, 'Rua das Palmeiras', 333, NULL, '40040-000', 6),
(7, 'Av. Independência', 444, 'Sala 10', '60000-000', 3),
(8, 'Rua Harmonia', 555, NULL, '70000-010', 11),
(9, 'Rua Santa Clara', 666, NULL, '22010-000', 2),
(10, 'Av. Sete de Setembro', 777, NULL, '40100-000', 6),
(11, 'Rua Santos Dumont', 888, 'Apto 3', '69000-000', 10),
(12, 'Rua Padre Cícero', 999, NULL, '63000-000', 7),
(13, 'Av. Rio Branco', 111, 'Loja A', '01020-000', 1),
(14, 'Rua Primavera', 222, NULL, '88000-000', 9),
(15, 'Rua Amazonas', 333, NULL, '78000-000', 19),
(16, 'Rua Goiás', 444, NULL, '74000-000', 20),
(17, 'Av. Paulista', 555, NULL, '01310-200', 1),
(18, 'Rua Bahia', 666, NULL, '70000-000', 3),
(19, 'Rua Maranhão', 777, 'Loja B', '60000-000', 18),
(20, 'Av. Atlântica', 888, NULL, '60100-000', 7);

-- Populando a tabela Empresa_de_Mudancas
INSERT INTO Empresa_de_Mudancas (id, nome, telefones, id_endereco) VALUES
(1, 'Mudanças SP', '11-99999-1111', 2),
(2, 'Mudanças RJ', '21-88888-2222', 4),
(3, 'Mudanças MG', '31-77777-3333', 7),
(4, 'Mudanças RS', '51-66666-4444', 8),
(5, 'Mudanças PR', '41-55555-5555', 3),
(6, 'Mudanças BA', '71-44444-6666', 6),
(7, 'Mudanças CE', '85-33333-7777', 12),
(8, 'Mudanças PE', '81-22222-8888', 14),
(9, 'Mudanças AM', '92-11111-9999', 11),
(10, 'Mudanças DF', '61-00000-0000', 16),
(11, 'Mudanças SC', '48-99999-1111', 15),
(12, 'Mudanças MT', '65-88888-2222', 19),
(13, 'Mudanças GO', '62-77777-3333', 20),
(14, 'Mudanças PB', '83-66666-4444', 17),
(15, 'Mudanças RN', '84-55555-5555', 18),
(16, 'Mudanças AL', '82-44444-6666', 13),
(17, 'Mudanças PA', '91-33333-7777', 12),
(18, 'Mudanças MA', '98-22222-8888', 19),
(19, 'Mudanças SE', '79-11111-9999', 10),
(20, 'Mudanças ES', '27-00000-0000', 5);

-- Populando a tabela Servico
INSERT INTO Servico (id, nome_servico, tipo_servico) VALUES
(1, 'Mudança Residencial', 'Residencial'),
(2, 'Mudança Comercial', 'Comercial'),
(3, 'Transporte de Cargas', 'Carga'),
(4, 'Transporte de Móveis', 'Especializado'),
(5, 'Mudança Internacional', 'Internacional');

-- Populando a tabela Cliente
INSERT INTO Cliente (id, codigo_cliente, cpf, rg, nome_completo, telefone, id_endereco) VALUES
(1, 1001, '12345678901', 'MG1234567', 'João Silva', '31-91234-5678', 7),
(2, 1002, '98765432101', 'SP7654321', 'Maria Souza', '11-99876-5432', 2),
(3, 1003, '45678912301', 'RJ2345678', 'Carlos Santos', '21-98765-4321', 4),
(4, 1004, '32165498701', 'BA3456789', 'Ana Oliveira', '71-91234-5678', 6),
(5, 1005, '78912345601', 'PR8765432', 'Pedro Almeida', '41-99876-5432', 3),
(6, 1006, '65432178901', 'RS9876543', 'Fernanda Lima', '51-98765-4321', 8),
(7, 1007, '98712365401', 'PE5678943', 'Roberto Costa', '81-91234-5678', 14),
(8, 1008, '65498732101', 'CE6789123', 'Patrícia Rocha', '85-99876-5432', 5),
(9, 1009, '32178965401', 'SC4321879', 'Rafael Menezes', '48-98765-4321', 15),
(10, 1010, '78965412301', 'AM5432187', 'Larissa Monteiro', '92-91234-5678', 11),
(11, 1011, '65432112301', 'SP1212345', 'Lucas Prado', '11-99876-5432', 1),
(12, 1012, '12345665401', 'RJ2345671', 'Camila Barbosa', '21-98765-4321', 4),
(13, 1013, '45678998701', 'BA3456788', 'Renata Martins', '71-91234-5678', 10),
(14, 1014, '32165412301', 'MG7654321', 'Fábio Ferreira', '31-99876-5432', 9),
(15, 1015, '78912378901', 'PE9876543', 'Beatriz Ramos', '81-98765-4321', 14),
(16, 1016, '65432198701', 'RS4321987', 'Gabriel Cardoso', '51-91234-5678', 7),
(17, 1017, '98712312301', 'CE5432198', 'Juliana Mendes', '85-99876-5432', 18),
(18, 1018, '65498798701', 'PA5671234', 'Leonardo Vieira', '91-98765-4321', 12),
(19, 1019, '32178932101', 'AL3456123', 'Débora Nogueira', '82-91234-5678', 13),
(20, 1020, '78965498701', 'RN9871234', 'Marcelo Teixeira', '84-99876-5432', 16);

-- Populando a tabela Funcionario
INSERT INTO Funcionario (id, cpf_funcionario, rg_funcionario, nome_completo, telefone_contato, tipo_funcionario, salario, id_endereco, id_empresa) VALUES
(1, '12345678901', 'SP1234567', 'José Silva', '11-91234-5678', 'Motorista', 2500.00, 1, 1),
(2, '98765432101', 'RJ7654321', 'Carlos Souza', '21-99876-5432', 'Ajudante', 1800.00, 4, 2),
(3, '45678912301', 'MG2345678', 'Luiza Santos', '31-98765-4321', 'Motorista', 2600.00, 7, 3),
(4, '32165498701', 'BA3456789', 'Antônio Oliveira', '71-91234-5678', 'Ajudante', 1900.00, 6, 6),
(5, '78912345601', 'PR8765432', 'Mariana Almeida', '41-99876-5432', 'Supervisor', 3000.00, 3, 5),
(6, '65498732100', 'SC3219874', 'Fernanda Costa', '48-91234-5678', 'Ajudante', 1850.00, 15, 11),
(7, '78945612300', 'RS6543218', 'Ricardo Nunes', '51-99876-5432', 'Motorista', 2700.00, 8, 4),
(8, '32145698700', 'SP9876543', 'Paula Mendes', '11-98765-4321', 'Supervisor', 3100.00, 17, 10),
(9, '65412378900', 'RJ1234567', 'Fabiana Rocha', '21-91234-5678', 'Ajudante', 1900.00, 9, 2),
(10, '98732165400', 'MG9873214', 'Rafael Lima', '31-99876-5432', 'Motorista', 2550.00, 7, 3),
(11, '12378945600', 'BA1239876', 'Lucas Albuquerque', '71-98765-4321', 'Ajudante', 1950.00, 6, 6),
(12, '78932165400', 'PR7896543', 'Juliana Ferreira', '41-91234-5678', 'Motorista', 2650.00, 3, 5),
(13, '45612398700', 'CE4567891', 'Anderson Ribeiro', '85-99876-5432', 'Ajudante', 1800.00, 5, 7),
(14, '98765412300', 'PE1234567', 'Patrícia Monteiro', '81-98765-4321', 'Supervisor', 3000.00, 14, 8),
(15, '12365478900', 'AM6549873', 'Fernando Santos', '92-91234-5678', 'Motorista', 2600.00, 11, 9),
(16, '65478912300', 'PA7896541', 'Bianca Carvalho', '91-99876-5432', 'Ajudante', 1850.00, 12, 17),
(17, '32198765400', 'PB3214567', 'Cláudia Souza', '83-98765-4321', 'Supervisor', 3200.00, 17, 14),
(18, '78912365400', 'MA9871234', 'Marcelo Vieira', '98-91234-5678', 'Motorista', 2700.00, 19, 18),
(19, '65432198700', 'RN6547893', 'Camila Barbosa', '84-99876-5432', 'Ajudante', 1900.00, 18, 15),
(20, '12345698700', 'SE3216549', 'Renato Oliveira', '79-98765-4321', 'Supervisor', 3100.00, 10, 19);

-- Populando a tabela Empresa_Servico_Cidade
INSERT INTO Empresa_Servico_Cidade (id, id_empresa, id_servico, id_cidade, preco_hora, taxa_excedente) VALUES
(1, 1, 1, 1, 150.00, 50.00),
(2, 2, 2, 2, 180.00, 60.00),
(3, 3, 3, 3, 200.00, 70.00),
(4, 4, 4, 4, 170.00, 55.00),
(5, 5, 5, 5, 190.00, 65.00),
(6, 6, 1, 6, 160.00, 50.00),
(7, 7, 2, 7, 175.00, 55.00),
(8, 8, 3, 8, 185.00, 60.00),
(9, 9, 4, 9, 210.00, 70.00),
(10, 10, 5, 10, 220.00, 75.00),
(11, 11, 1, 11, 155.00, 50.00),
(12, 12, 2, 12, 180.00, 60.00),
(13, 13, 3, 13, 195.00, 65.00),
(14, 14, 4, 14, 205.00, 70.00),
(15, 15, 5, 15, 215.00, 75.00),
(16, 16, 1, 16, 165.00, 55.00),
(17, 17, 2, 17, 185.00, 60.00),
(18, 18, 3, 18, 195.00, 65.00),
(19, 19, 4, 19, 205.00, 70.00),
(20, 20, 5, 20, 225.00, 80.00);

-- Populando a tabela Pedido
INSERT INTO Pedido (id, codigo_pedido, data_solicitacao, data_resolucao, preco_total, status, id_endereco_partida, id_endereco_destino, data_efetiva, id_cliente) VALUES
(1, 10001, '2024-10-01', '2024-10-02', 500.00, 'Concluído', 1, 2, '2024-10-02', 1),
(2, 10002, '2024-10-03', '2024-10-04', 700.00, 'Concluído', 3, 4, '2024-10-04', 2),
(3, 10003, '2024-10-05', '2024-10-06', 300.00, 'Cancelado', 5, 6, '2024-10-06', 3),
(4, 10004, '2024-10-07', '2024-10-08', 450.00, 'Concluído', 7, 8, '2024-10-08', 4),
(5, 10005, '2024-10-09', '2024-10-10', 600.00, 'Concluído', 9, 10, '2024-10-10', 5),
(6, 10006, '2024-10-11', NULL, 0.00, 'Em andamento', 11, 12, NULL, 6),
(7, 10007, '2024-10-12', '2024-10-13', 350.00, 'Cancelado', 13, 14, '2024-10-13', 7),
(8, 10008, '2024-10-14', '2024-10-15', 800.00, 'Concluído', 15, 16, '2024-10-15', 8),
(9, 10009, '2024-10-16', NULL, 0.00, 'Em andamento', 17, 18, NULL, 9),
(10, 10010, '2024-10-17', '2024-10-18', 900.00, 'Concluído', 19, 20, '2024-10-18', 10),
(11, 10011, '2024-10-19', '2024-10-20', 400.00, 'Concluído', 1, 3, '2024-10-20', 11),
(12, 10012, '2024-10-21', '2024-10-22', 500.00, 'Concluído', 4, 5, '2024-10-22', 12),
(13, 10013, '2024-10-23', NULL, 0.00, 'Em andamento', 6, 7, NULL, 13),
(14, 10014, '2024-10-24', '2024-10-25', 700.00, 'Concluído', 8, 9, '2024-10-25', 14),
(15, 10015, '2024-10-26', '2024-10-27', 600.00, 'Cancelado', 10, 11, '2024-10-27', 15),
(16, 10016, '2024-10-28', NULL, 0.00, 'Em andamento', 12, 13, NULL, 16),
(17, 10017, '2024-10-29', '2024-10-30', 550.00, 'Concluído', 14, 15, '2024-10-30', 17),
(18, 10018, '2024-10-31', '2024-11-01', 750.00, 'Concluído', 16, 17, '2024-11-01', 18),
(19, 10019, '2024-11-02', NULL, 0.00, 'Em andamento', 18, 19, NULL, 19),
(20, 10020, '2024-11-03', '2024-11-04', 650.00, 'Concluído', 20, 1, '2024-11-04', 20);

-- Populando a tabela Pedido_Servico
INSERT INTO Pedido_Servico (id, id_pedido, id_empresa_servico_cidade, tempo_execucao) VALUES
(1, 1, 1, '02:30:00'),
(2, 2, 2, '03:00:00'),
(3, 3, 3, '01:30:00'),
(4, 4, 4, '02:00:00'),
(5, 5, 5, '02:45:00'),
(6, 6, 6, NULL),
(7, 7, 7, '01:15:00'),
(8, 8, 8, '03:30:00'),
(9, 9, 9, NULL),
(10, 10, 10, '04:00:00'),
(11, 11, 11, '02:20:00'),
(12, 12, 12, '01:50:00'),
(13, 13, 13, NULL),
(14, 14, 14, '02:10:00'),
(15, 15, 15, '01:40:00'),
(16, 16, 16, NULL),
(17, 17, 17, '02:35:00'),
(18, 18, 18, '03:10:00'),
(19, 19, 19, NULL),
(20, 20, 20, '02:50:00');

-- Populando a tabela Pedido_Servico_Funcionario
INSERT INTO Pedido_Servico_Funcionario (id, id_pedido_servico, id_funcionario) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10),
(11, 11, 11),
(12, 12, 12),
(13, 13, 13),
(14, 14, 14),
(15, 15, 15),
(16, 16, 16),
(17, 17, 17),
(18, 18, 18),
(19, 19, 19),
(20, 20, 20);
