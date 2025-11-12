CREATE DATABASE petshop IF NOT EXISTS petshop;
USE petshop;

DELIMITER //

-- 1. Trigger para validar estoque antes de inserir um produto
CREATE TRIGGER trg_check_estoque_before_insert_produto
BEFORE INSERT ON produtos
FOR EACH ROW
BEGIN
    IF NEW.estoque < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque não pode ser negativo.';
    END IF;
END;
//

-- 2. Trigger para atualizar campo 'updated_at' após update em produtos
CREATE TRIGGER trg_update_timestamp_produto
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END;
//

-- 3. Trigger para impedir delete em tutores que ainda têm animais cadastrados
CREATE TRIGGER trg_no_delete_tutor_with_animais
BEFORE DELETE ON tutores
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM animais WHERE tutor_id = OLD.id) > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não é possível excluir tutor com animais cadastrados.';
    END IF;
END;
//

-- 4. Trigger para atualizar estoque após venda (exemplo hipotético, atualiza após inserir atendimento que venda produto)
CREATE TRIGGER trg_update_estoque_after_insert_atendimento
AFTER INSERT ON atendimentos
FOR EACH ROW
BEGIN
    UPDATE produtos
    SET estoque = estoque - 1
    WHERE id = NEW.produto_id;
END;
//

-- 5. Trigger para logar alteração de preço do produto
CREATE TABLE IF NOT EXISTS log_preco_produto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    preco_antigo DECIMAL(10,2),
    preco_novo DECIMAL(10,2),
    data_alteracao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER trg_log_preco_produto
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF OLD.preco <> NEW.preco THEN
        INSERT INTO log_preco_produto (produto_id, preco_antigo, preco_novo)
        VALUES (OLD.id, OLD.preco, NEW.preco);
    END IF;
END;
//

-- 6. Trigger para atualizar a data de cadastro de um tutor ao inserir
CREATE TRIGGER trg_set_data_cadastro_tutor
BEFORE INSERT ON tutores
FOR EACH ROW
BEGIN
    SET NEW.data_cadastro = NOW();
END;
//

-- 7. Trigger para impedir atualização do nome do tutor para vazio
CREATE TRIGGER trg_check_nome_tutor_before_update
BEFORE UPDATE ON tutores
FOR EACH ROW
BEGIN
    IF NEW.nome = '' OR NEW.nome IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome do tutor não pode ser vazio.';
    END IF;
END;
//

-- 8. Trigger para atualizar total de atendimentos em funcionário após inserir atendimento
ALTER TABLE funcionarios ADD COLUMN total_atendimentos INT DEFAULT 0;

CREATE TRIGGER trg_update_total_atendimentos_after_insert
AFTER INSERT ON atendimentos
FOR EACH ROW
BEGIN
    UPDATE funcionarios
    SET total_atendimentos = total_atendimentos + 1
    WHERE id = NEW.funcionario_id;
END;
//

-- 9. Trigger para reduzir total_atendimentos após delete de atendimento
CREATE TRIGGER trg_update_total_atendimentos_after_delete
AFTER DELETE ON atendimentos
FOR EACH ROW
BEGIN
    UPDATE funcionarios
    SET total_atendimentos = total_atendimentos - 1
    WHERE id = OLD.funcionario_id;
END;
//

-- 10. Trigger para atualizar o campo 'ultima_visita' do tutor após atendimento
ALTER TABLE tutores ADD COLUMN ultima_visita DATE NULL;

CREATE TRIGGER trg_update_ultima_visita_tutor
AFTER INSERT ON atendimentos
FOR EACH ROW
BEGIN
    UPDATE tutores
    SET ultima_visita = NEW.data_atendimento
    WHERE id = (SELECT tutor_id FROM animais WHERE id = NEW.animal_id);
END;
//

-- 11. Trigger para impedir inserir animal com idade negativa
CREATE TRIGGER trg_check_idade_animal_before_insert
BEFORE INSERT ON animais
FOR EACH ROW
BEGIN
    IF NEW.idade < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Idade do animal não pode ser negativa.';
    END IF;
END;
//

-- 12. Trigger para atualizar data de nascimento estimada do animal (exemplo hipotético)
-- Suponha que idade em anos seja convertida em data de nascimento aproximada (ano atual - idade)
ALTER TABLE animais ADD COLUMN data_nascimento DATE;

CREATE TRIGGER trg_set_data_nascimento_animal
BEFORE INSERT ON animais
FOR EACH ROW
BEGIN
    SET NEW.data_nascimento = DATE_SUB(CURDATE(), INTERVAL NEW.idade YEAR);
END;
//

-- 13. Trigger para logar deletação de tutores
CREATE TABLE IF NOT EXISTS log_delete_tutores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tutor_id INT,
    nome VARCHAR(100),
    data_delete DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER trg_log_delete_tutor
AFTER DELETE ON tutores
FOR EACH ROW
BEGIN
    INSERT INTO log_delete_tutores (tutor_id, nome)
    VALUES (OLD.id, OLD.nome);
END;
//

-- 14. Trigger para atualizar valor total do estoque (exemplo simplificado)
ALTER TABLE produtos ADD COLUMN valor_estoque DECIMAL(12,2) DEFAULT 0;

CREATE TRIGGER trg_update_valor_estoque_after_update
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    UPDATE produtos
    SET valor_estoque = preco * estoque
    WHERE id = NEW.id;
END;
//

-- 15. Trigger para impedir alteração de nome do produto para vazio
CREATE TRIGGER trg_check_nome_produto_before_update
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF NEW.nome = '' OR NEW.nome IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nome do produto não pode ser vazio.';
    END IF;
END;
//

-- 16. Trigger para impedir inserção de serviço com preço negativo
CREATE TRIGGER trg_check_preco_servico_before_insert
BEFORE INSERT ON servicos
FOR EACH ROW
BEGIN
    IF NEW.preco < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Preço do serviço não pode ser negativo.';
    END IF;
END;
//

-- 17. Trigger para atualizar contador de serviços prestados por funcionário
ALTER TABLE funcionarios ADD COLUMN total_servicos INT DEFAULT 0;

CREATE TRIGGER trg_update_total_servicos_after_insert
AFTER INSERT ON atendimentos
FOR EACH ROW
BEGIN
    UPDATE funcionarios
    SET total_servicos = total_servicos + 1
    WHERE id = NEW.funcionario_id;
END;
//

-- 18. Trigger para reduzir contador de serviços após delete de atendimento
CREATE TRIGGER trg_update_total_servicos_after_delete
AFTER DELETE ON atendimentos
FOR EACH ROW
BEGIN
    UPDATE funcionarios
    SET total_servicos = total_servicos - 1
    WHERE id = OLD.funcionario_id;
END;
//

-- 19. Trigger para validar formato de email do tutor
CREATE TRIGGER trg_check_email_tutor_before_insert
BEFORE INSERT ON tutores
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%_@__%.__%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email inválido.';
    END IF;
END;
//

-- 20. Trigger para impedir update de estoque para valor negativo
CREATE TRIGGER trg_check_estoque_before_update_produto
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF NEW.estoque < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque não pode ser negativo.';
    END IF;
END;
//

-- 21. Trigger para atualizar nome do tutor para capitalizado (exemplo simples)
CREATE TRIGGER trg_capitalize_nome_tutor_before_insert
BEFORE INSERT ON tutores
FOR EACH ROW
BEGIN
    SET NEW.nome = CONCAT(UCASE(LEFT(NEW.nome,1)), LCASE(SUBSTRING(NEW.nome,2)));
END;
//

-- 22. Trigger para atualizar nome do tutor para capitalizado no update
CREATE TRIGGER trg_capitalize_nome_tutor_before_update
BEFORE UPDATE ON tutores
FOR EACH ROW
BEGIN
    SET NEW.nome = CONCAT(UCASE(LEFT(NEW.nome,1)), LCASE(SUBSTRING(NEW.nome,2)));
END;
//

-- 23. Trigger para impedir inserção de funcionário com cargo inexistente
CREATE TRIGGER trg_check_cargo_funcionario_before_insert
BEFORE INSERT ON funcionarios
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM cargos WHERE id = NEW.cargo_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cargo inválido para funcionário.';
    END IF;
END;
//

-- 24. Trigger para impedir update de funcionário com cargo inexistente
CREATE TRIGGER trg_check_cargo_funcionario_before_update
BEFORE UPDATE ON funcionarios
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM cargos WHERE id = NEW.cargo_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cargo inválido para funcionário.';
    END IF;
END;
//

-- 25. Trigger para impedir inserção de animal com tutor inexistente
CREATE TRIGGER trg_check_tutor_animal_before_insert
BEFORE INSERT ON animais
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM tutores WHERE id = NEW.tutor_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tutor inválido para animal.';
    END IF;
END;
//

-- 26. Trigger para impedir update de animal com tutor inexistente
CREATE TRIGGER trg_check_tutor_animal_before_update
BEFORE UPDATE ON animais
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM tutores WHERE id = NEW.tutor_id) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tutor inválido para animal.';
    END IF;
END;
//

-- 27. Trigger para incrementar contador de animais por tutor após insert
ALTER TABLE tutores ADD COLUMN total_animais INT DEFAULT 0;

CREATE TRIGGER trg_increment_total_animais_after_insert
AFTER INSERT ON animais
FOR EACH ROW
BEGIN
    UPDATE tutores SET total_animais = total_animais + 1 WHERE id = NEW.tutor_id;
END;
//

-- 28. Trigger para decrementar contador de animais por tutor após delete
CREATE TRIGGER trg_decrement_total_animais_after_delete
AFTER DELETE ON animais
FOR EACH ROW
BEGIN
    UPDATE tutores SET total_animais = total_animais - 1 WHERE id = OLD.tutor_id;
END;
//

-- 29. Trigger para impedir inserção de produto com preço negativo
CREATE TRIGGER trg_check_preco_produto_before_insert
BEFORE INSERT ON produtos
FOR EACH ROW
BEGIN
    IF NEW.preco < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Preço do produto não pode ser negativo.';
    END IF;
END;
//

-- 30. Trigger para impedir update de produto com preço negativo
CREATE TRIGGER trg_check_preco_produto_before_update
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF NEW.preco < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Preço do produto não pode ser negativo.';
    END IF;
END;
//

-- 31. Trigger para registrar log de inserção de atendimento
CREATE TABLE IF NOT EXISTS log_atendimentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    atendimento_id INT,
    data_log DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER trg_log_insert_atendimento
AFTER INSERT ON atendimentos
FOR EACH ROW
BEGIN
    INSERT INTO log_atendimentos (atendimento_id) VALUES (NEW.id);
END;
//

-- 32. Trigger para impedir delete de produto com estoque maior que zero
CREATE TRIGGER trg_no_delete_produto_estoque
BEFORE DELETE ON produtos
FOR EACH ROW
BEGIN
    IF OLD.estoque > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Não pode deletar produto com estoque disponível.';
    END IF;
END;
//

-- 33. Trigger para impedir inserir atendimento com data futura
CREATE TRIGGER trg_check_data_futura_atendimento
BEFORE INSERT ON atendimentos
FOR EACH ROW
BEGIN
    IF NEW.data_atendimento > NOW() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data do atendimento não pode ser futura.';
    END IF;
END;
//

-- 34. Trigger para impedir update de atendimento com data futura
CREATE TRIGGER trg_check_data_futura_atendimento_update
BEFORE UPDATE ON atendimentos
FOR EACH ROW
BEGIN
    IF NEW.data_atendimento > NOW() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data do atendimento não pode ser futura.';
    END IF;
END;
//

-- 35. Trigger para atualizar data de última modificação de funcionário
ALTER TABLE funcionarios ADD COLUMN updated_at DATETIME NULL;

CREATE TRIGGER trg_update_funcionario_updated_at
BEFORE UPDATE ON funcionarios
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END;
//

DELIMITER ;
