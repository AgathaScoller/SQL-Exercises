CREATE DATABASE IF NOT EXISTS LojaIA;
USE LojaIA;

CREATE TABLE Categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

INSERT INTO Categorias (nome) VALUES
('Hardware para IA'),
('Livros e Guias'),
('Cursos e Licenças'),
('Acessórios e Gadgets');

CREATE TABLE Produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

INSERT INTO Produtos (nome, descricao, preco, estoque, id_categoria) VALUES
('GPU NVIDIA RTX 5090 AI Edition', 'Placa de vídeo otimizada para treinamento de redes neurais profundas', 19999.90, 10, 1),
('TPU Google Edge AI', 'Unidade de processamento de tensores para inferência em tempo real', 8999.00, 5, 1),
('Livro Deep Learning Aplicado', 'Obra detalhada sobre redes neurais e aplicações práticas', 249.90, 30, 2),
('Curso Completo de Machine Learning', 'Curso online com certificado e projetos práticos', 499.00, 100, 3),
('Assinatura ChatGPT Pro 1 Ano', 'Acesso premium à API de IA com recursos avançados', 1199.00, 50, 3),
('Caneca Neural Style', 'Caneca com arte inspirada em redes neurais convolucionais', 59.90, 40, 4),
('Mousepad com Circuitos de IA', 'Mousepad gamer com design neural', 89.90, 35, 4);

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    endereco VARCHAR(200)
);

INSERT INTO Clientes (nome, email, telefone, endereco) VALUES
('Lucas Andrade', 'lucas@ia.com', '11988887777', 'Rua dos Dados 42, São Paulo'),
('Beatriz Costa', 'beatriz@aihub.io', '21999998888', 'Av. Neural 101, Rio de Janeiro'),
('Gabriel Nunes', 'gabriel@mltech.ai', '31977776666', 'Rua TensorFlow 58, Belo Horizonte');

CREATE TABLE Funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cargo VARCHAR(50)
);

INSERT INTO Funcionarios (nome, cargo) VALUES
('Eduardo Lima', 'Atendimento'),
('Vanessa Ribeiro', 'Gerente de Vendas'),
('Sabrina Souza', 'Técnico de Suporte');

CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_funcionario INT,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    forma_pagamento VARCHAR(20),
    origem VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionarios(id_funcionario)
);

INSERT INTO Pedidos (id_cliente, id_funcionario, forma_pagamento, origem) VALUES
(1, NULL, 'Cartão', 'Online'),
(2, 1, 'Dinheiro', 'Balcão'),
(3, NULL, 'Pix', 'Online'),
(1, 2, 'Dinheiro', 'Balcão');

CREATE TABLE Itens_Pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

INSERT INTO Itens_Pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 19999.90),
(1, 6, 2, 59.90),
(2, 4, 1, 299.90),
(3, 5, 1, 1199.00),
(4, 3, 1, 249.90);

SELECT p.id_pedido, c.nome AS cliente, f.nome AS funcionario, p.forma_pagamento, p.origem, p.data_pedido
FROM Pedidos p
LEFT JOIN Clientes c ON p.id_cliente = c.id_cliente
LEFT JOIN Funcionarios f ON p.id_funcionario = f.id_funcionario;

SELECT i.id_item, pr.nome AS produto, i.quantidade, i.preco_unitario, (i.quantidade * i.preco_unitario) AS total
FROM Itens_Pedido i
JOIN Produtos pr ON i.id_produto = pr.id_produto;
