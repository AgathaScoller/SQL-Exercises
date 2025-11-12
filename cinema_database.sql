CREATE DATABASE IF NOT EXISTS CinemaDB;
USE CinemaDB;

CREATE TABLE Filmes (
    id_filme INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    genero VARCHAR(50),
    duracao INT,
    classificacao VARCHAR(10),
    preco_base DECIMAL(6,2)
);

INSERT INTO Filmes (titulo, genero, duracao, classificacao, preco_base) VALUES
('Duna: Parte Dois', 'Ficção Científica', 165, '14', 32.00),
('Divertida Mente 2', 'Animação', 100, 'L', 25.00),
('Coringa: Delírio a Dois', 'Drama', 120, '16', 35.00),
('Venom 3', 'Ação', 110, '14', 30.00);

CREATE TABLE Salas (
    id_sala INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(20),
    capacidade INT,
    tipo VARCHAR(30)
);

INSERT INTO Salas (nome, capacidade, tipo) VALUES
('Sala 1', 120, '2D'),
('Sala 2', 100, '3D'),
('Sala 3', 80, 'IMAX');

CREATE TABLE Sessoes (
    id_sessao INT AUTO_INCREMENT PRIMARY KEY,
    id_filme INT,
    id_sala INT,
    horario DATETIME,
    preco DECIMAL(6,2),
    FOREIGN KEY (id_filme) REFERENCES Filmes(id_filme),
    FOREIGN KEY (id_sala) REFERENCES Salas(id_sala)
);

INSERT INTO Sessoes (id_filme, id_sala, horario, preco) VALUES
(1, 1, '2025-11-12 18:00:00', 32.00),
(1, 3, '2025-11-12 21:30:00', 38.00),
(2, 1, '2025-11-12 14:00:00', 25.00),
(3, 2, '2025-11-12 20:00:00', 35.00),
(4, 1, '2025-11-13 22:00:00', 30.00);

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20)
);

INSERT INTO Clientes (nome, email, telefone) VALUES
('João Pereira', 'joao@gmail.com', '11987654321'),
('Marina Silva', 'marina@gmail.com', '21999998888'),
('Carlos Santos', 'carlos@hotmail.com', '11988887777');

CREATE TABLE Funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cargo VARCHAR(50)
);

INSERT INTO Funcionarios (nome, cargo) VALUES
('Henrique Souza', 'Atendente'),
('Vitor Almeida', 'Atendente'),
('Lorena Duarte', 'Gerente');

CREATE TABLE Vendas (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_sessao INT,
    id_cliente INT,
    id_funcionario INT,
    forma_pagamento VARCHAR(20),
    origem VARCHAR(20),
    data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_sessao) REFERENCES Sessoes(id_sessao),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionarios(id_funcionario)
);

INSERT INTO Vendas (id_sessao, id_cliente, id_funcionario, forma_pagamento, origem) VALUES
(1, 1, NULL, 'Cartão', 'Online'),
(2, 2, NULL, 'Pix', 'Online'),
(3, 3, 1, 'Dinheiro', 'Balcão'),
(4, 1, 2, 'Dinheiro', 'Balcão');

SELECT s.id_sessao, f.titulo, sl.nome AS sala, s.horario, s.preco
FROM Sessoes s
JOIN Filmes f ON s.id_filme = f.id_filme
JOIN Salas sl ON s.id_sala = sl.id_sala;

SELECT v.id_venda, c.nome AS cliente, f.nome AS funcionario, v.forma_pagamento, v.origem
FROM Vendas v
LEFT JOIN Clientes c ON v.id_cliente = c.id_cliente
LEFT JOIN Funcionarios f ON v.id_funcionario = f.id_funcionario;
