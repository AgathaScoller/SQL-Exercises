CREATE DATABASE petshop IF NOT EXISTS petshop;
USE petshop;

-- ====================
-- STRING FUNCTIONS
-- ====================

-- 1. Seleciona o nome do tutor em letras maiúsculas
SELECT UPPER(nome) FROM tutores;

-- 2. Seleciona o nome do tutor em letras minúsculas
SELECT LOWER(nome) FROM tutores;

-- 3. Pega os primeiros 4 caracteres do nome do produto
SELECT LEFT(nome, 4) FROM produtos;

-- 4. Pega os últimos 3 caracteres do nome do produto
SELECT RIGHT(nome, 3) FROM produtos;

-- 5. Retira espaços em branco no começo e fim do nome do tutor
SELECT TRIM(nome) FROM tutores;

-- 6. Substitui "Cachorro" por "Cão" no nome dos animais
SELECT REPLACE(nome, 'Cachorro', 'Cão') FROM animais;

-- 7. Concatena nome do tutor com telefone
SELECT CONCAT(nome, ' - ', telefone) FROM tutores;

-- 8. Encontra a posição da palavra 'Premium' no nome do produto
SELECT INSTR(nome, 'Premium') FROM produtos;

-- 9. Conta o comprimento do nome do tutor
SELECT LENGTH(nome) FROM tutores;

-- 10. Conta o número de caracteres (considera multi-byte) do nome do tutor
SELECT CHAR_LENGTH(nome) FROM tutores;


-- ====================
-- DATE FUNCTIONS
-- ====================

-- 11. Mostra a data atual
SELECT CURDATE();

-- 12. Mostra a hora atual
SELECT CURTIME();

-- 13. Mostra data e hora atuais
SELECT NOW();

-- 14. Extrai o ano da data de admissão dos funcionários
SELECT YEAR(data_admissao) FROM funcionarios;

-- 15. Extrai o mês da data de atendimento
SELECT MONTH(data_atendimento) FROM atendimentos;

-- 16. Extrai o dia do mês da data de nascimento dos animais
SELECT DAY(data_nascimento) FROM animais;

-- 17. Soma 10 dias à data atual
SELECT DATE_ADD(CURDATE(), INTERVAL 10 DAY);

-- 18. Subtrai 5 meses da data atual
SELECT DATE_SUB(CURDATE(), INTERVAL 5 MONTH);

-- 19. Calcula a diferença em dias entre duas datas (ex: hoje e data de admissão)
SELECT DATEDIFF(CURDATE(), data_admissao) FROM funcionarios;

-- 20. Formata a data de atendimento no formato 'dd/mm/yyyy'
SELECT DATE_FORMAT(data_atendimento, '%d/%m/%Y') FROM atendimentos;


-- ====================
-- NUMERIC FUNCTIONS
-- ====================

-- 21. Arredonda o preço dos produtos para 0 casas decimais
SELECT ROUND(preco, 0) FROM produtos;

-- 22. Arredonda o preço dos produtos para 2 casas decimais
SELECT ROUND(preco, 2) FROM produtos;

-- 23. Arredonda para baixo (floor)
SELECT FLOOR(preco) FROM produtos;

-- 24. Arredonda para cima (ceil)
SELECT CEIL(preco) FROM produtos;

-- 25. Retorna o valor absoluto de uma diferença (exemplo)
SELECT ABS(preco - 100) FROM produtos;

-- 26. Gera um número aleatório entre 0 e 1
SELECT RAND();

-- 27. Gera um número aleatório entre 1 e 100
SELECT FLOOR(1 + (RAND() * 100));

-- 28. Retorna o maior valor entre preço e 50
SELECT GREATEST(preco, 50) FROM produtos;

-- 29. Retorna o menor valor entre preço e 50
SELECT LEAST(preco, 50) FROM produtos;

-- 30. Soma o estoque e 10
SELECT estoque + 10 FROM produtos;


-- ====================
-- COMBINANDO FUNÇÕES
-- ====================

-- 31. Concatena nome e telefone, com o nome em maiúsculas
SELECT CONCAT(UPPER(nome), ' - ', telefone) FROM tutores;

-- 32. Extrai o ano e concatena com o nome do funcionário
SELECT CONCAT(YEAR(data_admissao), ' - ', nome) FROM funcionarios;

-- 33. Calcula o tempo desde a admissão do funcionário em dias
SELECT DATEDIFF(CURDATE(), data_admissao) AS dias_trabalhados FROM funcionarios;

-- 34. Mostra o nome do produto e o preço arredondado para cima
SELECT nome, CEIL(preco) AS preco_arredondado FROM produtos;

-- 35. Substitui "Adulto" por "Ad" no nome do produto e converte para maiúscula
SELECT UPPER(REPLACE(nome, 'Adulto', 'Ad')) FROM produtos;

-- 36. Mostra o nome do tutor e quantos animais ele tem (subquery)
SELECT nome, (SELECT COUNT(*) FROM animais WHERE tutor_id = tutores.id) AS total_animais FROM tutores;

-- 37. Calcula o estoque total multiplicado pelo preço arredondado
SELECT ROUND(preco,2) * estoque AS valor_total FROM produtos;

-- 38. Mostra o nome do tutor com o telefone formatado (retira espaços)
SELECT CONCAT(nome, ' - ', REPLACE(telefone, ' ', '')) FROM tutores;

-- 39. Extrai o mês e ano da data de atendimento e concatena
SELECT CONCAT(MONTH(data_atendimento), '/', YEAR(data_atendimento)) AS mes_ano FROM atendimentos;

-- 40. Conta quantos tutores têm email cadastrado
SELECT COUNT(*) FROM tutores WHERE email IS NOT NULL AND email <> '';
