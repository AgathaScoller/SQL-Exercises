CREATE DATABASE petshop IF NOT EXISTS petshop;
USE petshop;

-- Exemplo 1: Inserir atendimento e atualizar estoque do produto
START TRANSACTION;

INSERT INTO atendimentos (animal_id, servico_id, funcionario_id, data_atendimento, produto_id)
VALUES (1, 2, 3, '2025-06-20', 4);

UPDATE produtos SET estoque = estoque - 1 WHERE id = 4;

COMMIT;


-- Exemplo 2: Transferência de estoque entre dois produtos
START TRANSACTION;

UPDATE produtos SET estoque = estoque - 10 WHERE id = 1;

UPDATE produtos SET estoque = estoque + 10 WHERE id = 2;

COMMIT;


-- Exemplo 3: Simulação de falha, para testar rollback
START TRANSACTION;

UPDATE produtos SET estoque = estoque - 1000 WHERE id = 1; -- pode falhar se estoque insuficiente

UPDATE produtos SET estoque = estoque + 1000 WHERE id = 2;

ROLLBACK; -- cancela tudo para não perder dados


-- Exemplo 4: Várias operações juntas em uma transação
START TRANSACTION;

INSERT INTO tutores (nome, telefone, email, endereco)
VALUES ('Novo Tutor', '61912345678', 'novo.tutor@email.com', 'Rua Nova, 100');

INSERT INTO animais (nome, especie, raca, idade, sexo, tutor_id)
VALUES ('Buddy', 'Cachorro', 'Beagle', 3, 'M', LAST_INSERT_ID());

UPDATE produtos SET estoque = estoque - 2 WHERE id = 5;

COMMIT;
