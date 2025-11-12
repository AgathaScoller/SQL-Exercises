CREATE petshop IF NOT EXISTS petshop;
USE petshop;


INSERT INTO cargos (nome) VALUES
('Veterinário'),
('Atendente'),
('Banho e Tosa'),
('Administrador');

INSERT INTO funcionarios (nome, cargo_id, data_admissao) VALUES
('Carla Ribeiro', 1, '2023-02-10'),
('João Lima', 2, '2023-05-22'),
('Fernanda Souza', 3, '2022-11-15'),
('Bruno Tavares', 4, '2021-08-01');

INSERT INTO tutores (nome, telefone, email, endereco) VALUES
('Ana Paula', '61999990001', 'ana.paula@gmail.com', 'Rua das Flores, 45 - Brasília'),
('Rodrigo Menezes', '61988887777', 'rodrigo.m@gmail.com', 'Av. Central, 102 - Taguatinga'),
('Maria Clara', '61999998888', 'clara.maria@gmail.com', 'SQN 207, Bloco B - Asa Norte');

INSERT INTO animais (nome, especie, raca, idade, sexo, tutor_id) VALUES
('Bolt', 'Cachorro', 'Golden Retriever', 3, 'M', 1),
('Mimi', 'Gato', 'Persa', 2, 'F', 2),
('Thor', 'Cachorro', 'Pitbull', 4, 'M', 2),
('Luna', 'Gato', 'Siamês', 1, 'F', 3),
('Rex', 'Cachorro', 'Vira-lata', 5, 'M', 1);

INSERT INTO produtos (nome, preco, estoque, descricao) VALUES
('Ração Golden - Cães Adultos', 129.90, 20, 'Ração premium para cães de médio porte'),
('Shampoo Antipulgas', 35.50, 50, 'Ideal para banho com proteção antiparasitária'),
('Coleira LED Noturna', 49.90, 15, 'Coleira com luz para passeios noturnos'),
('Areia Higiênica para Gatos', 25.00, 30, 'Areia absorvente e sem cheiro'),
('Brinquedo Mordedor', 18.75, 40, 'Brinquedo de borracha para cães de pequeno porte');

INSERT INTO servicos (nome, preco, duracao_min, descricao) VALUES
('Consulta Veterinária', 150.00, 30, 'Avaliação clínica geral do animal'),
('Banho Simples', 40.00, 45, 'Banho com shampoo neutro e secagem'),
('Tosa Higiênica', 60.00, 30, 'Corte higiênico e limpeza de áreas íntimas'),
('Vacinação Antirrábica', 70.00, 15, 'Aplicação da vacina contra raiva'),
('Banho Medicinal', 85.00, 50, 'Banho com shampoo terapêutico e acompanhamento');

INSERT INTO atendimentos (animal_id, servico_id, funcionario_id, data_atendimento, observacoes) VALUES
(1, 1, 1, '2025-06-10 10:00:00', 'Animal saudável, sem sinais de febre.'),
(2, 2, 3, '2025-06-11 14:00:00', 'Banho sem intercorrências.'),
(3, 4, 1, '2025-06-12 09:30:00', 'Vacina aplicada com sucesso.'),
(4, 3, 3, '2025-06-12 16:00:00', 'Animal agitado, necessário 2 pessoas.'),
(5, 5, 1, '2025-06-13 11:15:00', 'Tratamento para dermatite iniciado.');
