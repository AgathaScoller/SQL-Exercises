CREATE DATABASE petshop IF NOT EXISTS petshop;
USE petshop;

-- INSERT — Inserir dados
INSERT INTO tutores (nome, telefone, email, endereco) 
VALUES ('Lucas Ferreira', '61977775555', 'lucas.ferreira@gmail.com', 'Rua das Acácias, 123 - Brasília');

INSERT INTO animais (nome, especie, raca, idade, sexo, tutor_id) 
VALUES ('Max', 'Cachorro', 'Labrador', 2, 'M', 4);

INSERT INTO produtos (nome, preco, estoque, descricao) 
VALUES ('Ração Premium', 150.00, 25, 'Ração para cães adultos');

-- UPDATE — Atualizar dados existentes
UPDATE tutores 
SET telefone = '61999994444' 
WHERE id = 2;

UPDATE produtos 
SET preco = 55.00 
WHERE id = 3;

UPDATE funcionarios 
SET nome = 'Carla Ribeiro Silva' 
WHERE id = 1;

-- DELETE — Apagar dados
DELETE FROM tutores 
WHERE id = 5;

DELETE FROM atendimentos 
WHERE data_atendimento < '2024-01-01';

DELETE FROM produtos 
WHERE id = 7;
