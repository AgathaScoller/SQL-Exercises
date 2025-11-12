USE petshop;

-- =========================
-- Consultas com IF, CASE, COALESCE, etc.
-- =========================

-- 1. Usando IF para verificar se o estoque é baixo
SELECT nome, estoque,
  IF(estoque < 10, 'Estoque baixo', 'Estoque OK') AS status_estoque
FROM produtos;

-- 2. Usando IF para identificar animais jovens ou adultos
SELECT nome, idade,
  IF(idade < 2, 'Jovem', 'Adulto') AS faixa_etaria
FROM animais;

-- 3. Usando CASE para categorizar preço dos produtos
SELECT nome, preco,
  CASE
    WHEN preco < 50 THEN 'Barato'
    WHEN preco BETWEEN 50 AND 150 THEN 'Médio'
    ELSE 'Caro'
  END AS categoria_preco
FROM produtos;

-- 4. Usando CASE para mostrar o sexo do animal em texto
SELECT nome, sexo,
  CASE sexo
    WHEN 'M' THEN 'Macho'
    WHEN 'F' THEN 'Fêmea'
    ELSE 'Desconhecido'
  END AS descricao_sexo
FROM animais;

-- 5. IFNULL para substituir valores nulos em telefone
SELECT nome, IFNULL(telefone, 'Sem telefone') AS telefone_contato
FROM tutores;

-- 6. COALESCE para retornar o primeiro valor não nulo
SELECT nome, COALESCE(email, telefone, 'Sem contato') AS contato
FROM tutores;

-- 7. NULLIF para comparar e retornar NULL se iguais
SELECT nome, preco, NULLIF(preco, 0) AS preco_nao_zero
FROM produtos;

-- 8. Usando IF para desconto em produto com preço maior que 100
SELECT nome, preco,
  IF(preco > 100, preco * 0.9, preco) AS preco_com_desconto
FROM produtos;

-- 9. CASE para mostrar se o funcionário está ativo com base na data
SELECT nome, data_demissao,
  CASE
    WHEN data_demissao IS NULL THEN 'Ativo'
    ELSE 'Inativo'
  END AS status_funcionario
FROM funcionarios;

-- 10. IF para verificar se animal tem tutor cadastrado
SELECT nome,
  IF(tutor_id IS NULL, 'Sem tutor', 'Com tutor') AS status_tutor
FROM animais;

-- 11. CASE para agrupar quantidade de animais por faixa etária
SELECT 
  CASE
    WHEN idade < 1 THEN 'Filhote'
    WHEN idade BETWEEN 1 AND 7 THEN 'Adulto'
    ELSE 'Idoso'
  END AS categoria_idade,
  COUNT(*) AS total_animais
FROM animais
GROUP BY categoria_idade;

-- 12. IF para mostrar se o atendimento foi no último mês
SELECT id, data_atendimento,
  IF(data_atendimento >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH), 'Recentes', 'Antigos') AS periodo
FROM atendimentos;

-- 13. CASE para definir faixa de dias desde admissão do funcionário
SELECT nome, data_admissao,
  CASE
    WHEN DATEDIFF(CURDATE(), data_admissao) < 365 THEN 'Recente'
    WHEN DATEDIFF(CURDATE(), data_admissao) BETWEEN 365 AND 1825 THEN 'Experiente'
    ELSE 'Veterano'
  END AS tempo_casa
FROM funcionarios;

-- 14. IF para verificar se o estoque é nulo ou zero
SELECT nome, estoque,
  IF(estoque IS NULL OR estoque = 0, 'Sem estoque', 'Em estoque') AS status_estoque
FROM produtos;

-- 15. CASE para informar status do tutor baseado no número de animais
SELECT nome,
  CASE
    WHEN (SELECT COUNT(*) FROM animais WHERE tutor_id = tutores.id) = 0 THEN 'Sem animais'
    ELSE 'Tem animais'
  END AS status_animais
FROM tutores;

-- 16. IF para mostrar se o preço do produto é múltiplo de 10
SELECT nome, preco,
  IF(preco % 10 = 0, 'Multiplo de 10', 'Nao multiplo de 10') AS multiplo_10
FROM produtos;

-- 17. CASE para classificar animais por espécie
SELECT nome, especie,
  CASE especie
    WHEN 'Cachorro' THEN 'Canino'
    WHEN 'Gato' THEN 'Felino'
    ELSE 'Outro'
  END AS grupo_especie
FROM animais;

-- 18. IF para exibir telefone formatado ou mensagem
SELECT nome,
  IF(telefone IS NOT NULL AND telefone <> '', telefone, 'Telefone não informado') AS telefone_info
FROM tutores;

-- 19. CASE para verificar se funcionário é gerente baseado no cargo
SELECT f.nome, c.nome AS cargo,
  CASE
    WHEN c.nome LIKE '%Gerente%' THEN 'Sim'
    ELSE 'Não'
  END AS eh_gerente
FROM funcionarios f
JOIN cargos c ON f.cargo_id = c.id;

-- 20. IFNULL para mostrar e-mail ou telefone do tutor
SELECT nome, IFNULL(email, telefone) AS contato_preferencial
FROM tutores;

-- 21. CASE para mostrar se o atendimento foi em fim de semana
SELECT id, data_atendimento,
  CASE DAYOFWEEK(data_atendimento)
    WHEN 1 THEN 'Domingo'
    WHEN 7 THEN 'Sábado'
    ELSE 'Dia de semana'
  END AS tipo_dia
FROM atendimentos;

-- 22. IF para desconto progressivo baseado em estoque
SELECT nome, estoque,
  IF(estoque > 50, 'Desconto 20%', IF(estoque > 20, 'Desconto 10%', 'Sem desconto')) AS desconto
FROM produtos;

-- 23. CASE para definir se animal está jovem, adulto ou idoso baseado na idade
SELECT nome, idade,
  CASE
    WHEN idade < 3 THEN 'Jovem'
    WHEN idade BETWEEN 3 AND 8 THEN 'Adulto'
    ELSE 'Idoso'
  END AS faixa_etaria
FROM animais;

-- 24. IF para mostrar se funcionário já saiu da empresa
SELECT nome, data_demissao,
  IF(data_demissao IS NULL, 'Ativo', 'Demissionário') AS status
FROM funcionarios;

-- 25. CASE para exibir faixa de preço dos produtos
SELECT nome, preco,
  CASE
    WHEN preco < 20 THEN 'Barato'
    WHEN preco BETWEEN 20 AND 100 THEN 'Médio'
    ELSE 'Caro'
  END AS faixa_preco
FROM produtos;

-- 26. IF para indicar se tutor tem e-mail cadastrado
SELECT nome,
  IF(email IS NULL OR email = '', 'Sem email', 'Com email') AS status_email
FROM tutores;

-- 27. CASE para mostrar se o atendimento foi hoje, ontem ou antes
SELECT id, data_atendimento,
  CASE
    WHEN DATE(data_atendimento) = CURDATE() THEN 'Hoje'
    WHEN DATE(data_atendimento) = DATE_SUB(CURDATE(), INTERVAL 1 DAY) THEN 'Ontem'
    ELSE 'Antes'
  END AS periodo
FROM atendimentos;

-- 28. IF para indicar se estoque é suficiente para venda de 5 unidades
SELECT nome, estoque,
  IF(estoque >= 5, 'Estoque suficiente', 'Estoque insuficiente') AS status_venda
FROM produtos;

-- 29. CASE para indicar se o funcionário está com mais de 5 anos na empresa
SELECT nome, data_admissao,
  CASE
    WHEN DATEDIFF(CURDATE(), data_admissao) > 1825 THEN 'Mais de 5 anos'
    ELSE 'Menos de 5 anos'
  END AS tempo_empresa
FROM funcionarios;

-- 30. IF para indicar se animal é macho e tem mais de 5 anos
SELECT nome, sexo, idade,
  IF(sexo = 'M' AND idade > 5, 'Macho velho', 'Outro') AS descricao
FROM animais;

-- =========================
-- Estrutura adicional para cinema Cinesystem (sem DROP e com CREATE IF NOT EXISTS)
-- =========================

CREATE TABLE IF NOT EXISTS categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);

-- Alterar tabela filmes para incluir categoria_id
-- Como MySQL não aceita ADD COLUMN IF NOT EXISTS, primeiro verificamos manualmente

-- Caso não exista, adicione manualmente essa coluna antes de rodar:
-- ALTER TABLE filmes ADD COLUMN categoria_id INT;

ALTER TABLE filmes 
  ADD CONSTRAINT IF NOT EXISTS fk_filmes_categoria FOREIGN KEY (categoria_id) REFERENCES categorias(id);

INSERT IGNORE INTO categorias (nome) VALUES
('Ação'), ('Drama'), ('Comédia'), ('Animação'), ('Terror'), ('Suspense'), ('Romance');

-- Atualizar filmes com categoria (exemplo)
UPDATE filmes SET categoria_id = (SELECT id FROM categorias WHERE nome = 'Sci-Fi') WHERE titulo = 'Inception';
UPDATE filmes SET categoria_id = (SELECT id FROM categorias WHERE nome = 'Drama') WHERE titulo IN ('Joker', 'Parasite', 'The Godfather');
UPDATE filmes SET categoria_id = (SELECT id FROM categorias WHERE nome = 'Romance') WHERE titulo = 'Titanic';
UPDATE filmes SET categoria_id = (SELECT id FROM categorias WHERE nome = 'Ação') WHERE titulo = 'Avengers: Endgame';
UPDATE filmes SET categoria_id = (SELECT id FROM categorias WHERE nome = 'Animação') WHERE titulo = 'Frozen II';

CREATE TABLE IF NOT EXISTS assentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sala_id INT NOT NULL,
    linha CHAR(1) NOT NULL,
    numero INT NOT NULL,
    UNIQUE KEY unq_sala_linha_numero (sala_id, linha, numero),
    FOREIGN KEY (sala_id) REFERENCES salas(id)
);

-- Populando assentos para sala 1 (10 filas, 10 assentos cada)
INSERT IGNORE INTO assentos (sala_id, linha, numero)
SELECT 1, CHAR(64 + seq1), seq2
FROM
 (SELECT 1 AS seq1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) AS filas,
 (SELECT 1 AS seq2 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) AS assentos;

CREATE TABLE IF NOT EXISTS reservas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sessao_id INT NOT NULL,
    assento_id INT NOT NULL,
    cliente_id INT NOT NULL,
    data_reserva TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ativa', 'cancelada', 'modificada') DEFAULT 'ativa',
    UNIQUE KEY unq_sessao_assento (sessao_id, assento_id),
    FOREIGN KEY (sessao_id) REFERENCES sessoes(id),
    FOREIGN KEY (assento_id) REFERENCES assentos(id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE IF NOT EXISTS formas_pagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

INSERT IGNORE INTO formas_pagamento (nome) VALUES
('Dinheiro'), ('Cartão de Crédito'), ('Cartão de Débito'), ('Pix'), ('Vale Refeição');

CREATE TABLE IF NOT EXISTS pagamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    forma_pagamento_id INT NOT NULL,
    referencia VARCHAR(100),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (forma_pagamento_id) REFERENCES formas_pagamento(id)
);

CREATE TABLE IF NOT EXISTS avaliacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    filme_id INT NOT NULL,
    nota INT NOT NULL CHECK (nota BETWEEN 1 AND 5),
    comentario TEXT,
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (filme_id) REFERENCES filmes(id)
);

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    funcionario_id INT NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    ultimo_login TIMESTAMP NULL,
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id)
);

CREATE TABLE IF NOT EXISTS fornecedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(255)
);

-- Para adicionar coluna fornecedor_id em produtos (sem IF NOT EXISTS, faça manual se já existir)
ALTER TABLE produtos ADD COLUMN fornecedor_id INT;

ALTER TABLE produtos
  ADD CONSTRAINT fk_produtos_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id);

INSERT IGNORE INTO fornecedores (nome, telefone, email, endereco) VALUES
('Fornecedor A', '61990001111', 'contato@fornecedora.com', 'Rua A, 123'),
('Fornecedor B', '61990002222', 'contato@fornecedorb.com', 'Rua B, 456');

UPDATE produtos SET fornecedor_id = 1 WHERE id IN (1, 3);
UPDATE produtos SET fornecedor_id = 2 WHERE id IN (2, 4, 5);

CREATE OR REPLACE VIEW vendas_detalhadas AS
SELECT vp.id AS venda_id,
       p.nome AS produto,
       c.nome AS cliente,
       vp.quantidade,
       vp.data_venda,
       p.preco,
       (vp.quantidade * p.preco) AS total
FROM vendas_produtos vp
JOIN produtos p ON vp.produto_id = p.id
JOIN clientes c ON vp.cliente_id = c.id;

-- PROCEDURE para cancelar reserva (atualiza status)
DELIMITER //
CREATE PROCEDURE cancelar_reserva(IN p_reserva_id INT)
BEGIN
  UPDATE reservas SET status = 'cancelada' WHERE id = p_reserva_id;
END;
//
DELIMITER ;
