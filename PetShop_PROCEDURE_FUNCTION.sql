CREATE DATABASE petshop IF NOT EXISTS petshop;
USE petshop;

DELIMITER //

-- PROCEDURES

-- 1. Procedure para inserir um novo tutor
CREATE PROCEDURE inserir_tutor (
    IN p_nome VARCHAR(100),
    IN p_telefone VARCHAR(20),
    IN p_email VARCHAR(100),
    IN p_endereco VARCHAR(255)
)
BEGIN
    INSERT INTO tutores (nome, telefone, email, endereco)
    VALUES (p_nome, p_telefone, p_email, p_endereco);
END;
//

-- 2. Procedure para atualizar o estoque de um produto
CREATE PROCEDURE atualizar_estoque_produto (
    IN p_produto_id INT,
    IN p_novo_estoque INT
)
BEGIN
    UPDATE produtos SET estoque = p_novo_estoque WHERE id = p_produto_id;
END;
//

-- 3. Procedure para deletar um atendimento pelo id
CREATE PROCEDURE deletar_atendimento (
    IN p_atendimento_id INT
)
BEGIN
    DELETE FROM atendimentos WHERE id = p_atendimento_id;
END;
//

-- 4. Procedure para listar os animais de um tutor específico
CREATE PROCEDURE listar_animais_tutor (
    IN p_tutor_id INT
)
BEGIN
    SELECT * FROM animais WHERE tutor_id = p_tutor_id;
END;
//

-- 5. Procedure para incrementar o estoque de um produto
CREATE PROCEDURE incrementar_estoque_produto (
    IN p_produto_id INT,
    IN p_quantidade INT
)
BEGIN
    UPDATE produtos SET estoque = estoque + p_quantidade WHERE id = p_produto_id;
END;
//


-- FUNCTIONS

-- 1. Function para retornar o total de animais de um tutor
CREATE FUNCTION total_animais_tutor (p_tutor_id INT) RETURNS INT
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM animais WHERE tutor_id = p_tutor_id;
    RETURN total;
END;
//

-- 2. Function para calcular o valor total do estoque de um produto (preço * estoque)
CREATE FUNCTION valor_estoque_produto (p_produto_id INT) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE valor DECIMAL(10,2);
    SELECT preco * estoque INTO valor FROM produtos WHERE id = p_produto_id;
    RETURN valor;
END;
//

-- 3. Function para verificar se um tutor existe pelo nome (retorna TRUE/FALSE)
CREATE FUNCTION tutor_existe (p_nome VARCHAR(100)) RETURNS BOOLEAN
BEGIN
    DECLARE existe INT;
    SELECT COUNT(*) INTO existe FROM tutores WHERE nome = p_nome;
    RETURN existe > 0;
END;
//

-- 4. Function para retornar a idade média dos animais de uma espécie
CREATE FUNCTION idade_media_especie (p_especie VARCHAR(50)) RETURNS DECIMAL(5,2)
BEGIN
    DECLARE media_idade DECIMAL(5,2);
    SELECT AVG(idade) INTO media_idade FROM animais WHERE especie = p_especie;
    RETURN media_idade;
END;
//

-- 5. Function para retornar o nome do tutor de um animal pelo id do animal
CREATE FUNCTION nome_tutor_animal (p_animal_id INT) RETURNS VARCHAR(100)
BEGIN
    DECLARE nome_tutor VARCHAR(100);
    SELECT t.nome INTO nome_tutor
    FROM tutores t
    JOIN animais a ON t.id = a.tutor_id
    WHERE a.id = p_animal_id;
    RETURN nome_tutor;
END;
//

DELIMITER ;
