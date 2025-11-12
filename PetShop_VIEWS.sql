CREATE DATABASE petshop IF NOT EXISTS petshop;
USE petshop;

-- 1. View com lista de animais e seus tutores
CREATE VIEW vw_animais_tutores AS
SELECT a.id AS animal_id, a.nome AS nome_animal, t.nome AS nome_tutor
FROM animais a
JOIN tutores t ON a.tutor_id = t.id;

-- 2. View com funcionários e seus cargos
CREATE VIEW vw_funcionarios_cargos AS
SELECT f.id, f.nome AS nome_funcionario, c.nome AS nome_cargo
FROM funcionarios f
JOIN cargos c ON f.cargo_id = c.id;

-- 3. View com produtos em estoque baixo (< 20)
CREATE VIEW vw_produtos_estoque_baixo AS
SELECT * FROM produtos WHERE estoque < 20;

-- 4. View com serviços e seus preços
CREATE VIEW vw_servicos_preco AS
SELECT id, nome, preco, duracao_min FROM servicos;

-- 5. View com tutores que possuem mais de 2 animais
CREATE VIEW vw_tutores_animais_maior_2 AS
SELECT t.id, t.nome, COUNT(a.id) AS total_animais
FROM tutores t
JOIN animais a ON a.tutor_id = t.id
GROUP BY t.id, t.nome
HAVING COUNT(a.id) > 2;

-- 6. View com atendimentos recentes (últimos 30 dias)
CREATE VIEW vw_atendimentos_recentes AS
SELECT * FROM atendimentos
WHERE data_atendimento >= CURDATE() - INTERVAL 30 DAY;

-- 7. View com total de animais por espécie
CREATE VIEW vw_total_animais_especie AS
SELECT especie, COUNT(*) AS total_animais
FROM animais
GROUP BY especie;

-- 8. View com média de idade dos animais por tutor
CREATE VIEW vw_media_idade_animais_tutor AS
SELECT tutor_id, AVG(idade) AS idade_media
FROM animais
GROUP BY tutor_id;

-- 9. View com funcionários admitidos em 2023
CREATE VIEW vw_funcionarios_2023 AS
SELECT * FROM funcionarios
WHERE YEAR(data_admissao) = 2023;

-- 10. View com produtos sem estoque
CREATE VIEW vw_produtos_sem_estoque AS
SELECT * FROM produtos WHERE estoque = 0;

-- 11. View com tutores que não possuem telefone cadastrado
CREATE VIEW vw_tutores_sem_telefone AS
SELECT * FROM tutores WHERE telefone IS NULL OR telefone = '';

-- 12. View com atendimentos por serviço
CREATE VIEW vw_atendimentos_servicos AS
SELECT servico_id, COUNT(*) AS total_atendimentos
FROM atendimentos
GROUP BY servico_id;

-- 13. View com funcionários que não realizaram atendimentos
CREATE VIEW vw_funcionarios_sem_atendimento AS
SELECT * FROM funcionarios WHERE id NOT IN (
  SELECT DISTINCT funcionario_id FROM atendimentos
);

-- 14. View com produtos com preço acima da média
CREATE VIEW vw_produtos_preco_acima_media AS
SELECT * FROM produtos WHERE preco > (
  SELECT AVG(preco) FROM produtos
);

-- 15. View com tutores cujo nome contém 'Maria'
CREATE VIEW vw_tutores_maria AS
SELECT * FROM tutores WHERE nome LIKE '%Maria%';

-- 16. View com animais que não receberam atendimento
CREATE VIEW vw_animais_sem_atendimento AS
SELECT * FROM animais WHERE id NOT IN (
  SELECT DISTINCT animal_id FROM atendimentos
);

-- 17. View com produtos agrupados por nome e preço somando estoque
CREATE VIEW vw_produtos_agrupados AS
SELECT nome, preco, SUM(estoque) AS estoque_total
FROM produtos
GROUP BY nome, preco;

-- 18. View com média de preço dos serviços por duração
CREATE VIEW vw_media_preco_servicos_duracao AS
SELECT duracao_min, AVG(preco) AS preco_medio
FROM servicos
GROUP BY duracao_min;

-- 19. View com tutores que possuem animais da espécie 'Gato'
CREATE VIEW vw_tutores_gatos AS
SELECT DISTINCT t.*
FROM tutores t
JOIN animais a ON t.id = a.tutor_id
WHERE a.especie = 'Gato';

-- 20. View com serviços que nunca foram realizados
CREATE VIEW vw_servicos_nao_realizados AS
SELECT * FROM servicos WHERE id NOT IN (
  SELECT DISTINCT servico_id FROM atendimentos
);

-- 21. View com atendimentos e nome do animal e tutor
CREATE VIEW vw_atendimentos_animais_tutores AS
SELECT at.id AS atendimento_id, a.nome AS nome_animal, t.nome AS nome_tutor, at.data_atendimento
FROM atendimentos at
JOIN animais a ON at.animal_id = a.id
JOIN tutores t ON a.tutor_id = t.id;

-- 22. View com funcionários e quantidade de atendimentos realizados
CREATE VIEW vw_funcionarios_total_atendimentos AS
SELECT f.id, f.nome, COUNT(at.id) AS total_atendimentos
FROM funcionarios f
LEFT JOIN atendimentos at ON f.id = at.funcionario_id
GROUP BY f.id, f.nome;

-- 23. View com produtos mais caros (preço acima de 100)
CREATE VIEW vw_produtos_caros AS
SELECT * FROM produtos WHERE preco > 100;

-- 24. View com tutores e quantidade de animais por tutor
CREATE VIEW vw_tutores_quantidade_animais AS
SELECT t.id, t.nome, COUNT(a.id) AS total_animais
FROM tutores t
LEFT JOIN animais a ON t.id = a.tutor_id
GROUP BY t.id;

-- 25. View com animais ordenados por idade e espécie
CREATE VIEW vw_animais_ordenados AS
SELECT * FROM animais ORDER BY idade DESC, especie ASC;

-- 26. View com funcionários ativos (admitidos antes de hoje)
CREATE VIEW vw_funcionarios_ativos AS
SELECT * FROM funcionarios WHERE data_admissao <= CURDATE();

-- 27. View com tutores e seus emails (filtrando email nulo)
CREATE VIEW vw_tutores_emails AS
SELECT nome, email FROM tutores WHERE email IS NOT NULL;

-- 28. View com atendimentos feitos por funcionário específico (exemplo: id = 1)
CREATE VIEW vw_atendimentos_funcionario_1 AS
SELECT * FROM atendimentos WHERE funcionario_id = 1;

-- 29. View com produtos cujo nome contém 'Ração'
CREATE VIEW vw_produtos_racao AS
SELECT * FROM produtos WHERE nome LIKE '%Ração%';

-- 30. View com serviços ordenados por duração
CREATE VIEW vw_servicos_ordenados_duracao AS
SELECT * FROM servicos ORDER BY duracao_min ASC;

-- 31. View com tutores que possuem telefone e email cadastrados
CREATE VIEW vw_tutores_com_contato AS
SELECT * FROM tutores WHERE telefone IS NOT NULL AND email IS NOT NULL;

-- 32. View com animais que têm tutor cadastrado (INNER JOIN)
CREATE VIEW vw_animais_com_tutor AS
SELECT a.*, t.nome AS nome_tutor FROM animais a
JOIN tutores t ON a.tutor_id = t.id;

-- 33. View com produtos ordenados por estoque e preço
CREATE VIEW vw_produtos_ordenados AS
SELECT * FROM produtos ORDER BY estoque DESC, preco ASC;

-- 34. View com funcionários e cargos, ordenados por cargo e nome
CREATE VIEW vw_funcionarios_cargos_ordenados AS
SELECT f.nome AS funcionario, c.nome AS cargo
FROM funcionarios f
JOIN cargos c ON f.cargo_id = c.id
ORDER BY c.nome ASC, f.nome ASC;

-- 35. View com atendimentos agrupados por serviço e mês
CREATE VIEW vw_atendimentos_servicos_mes AS
SELECT servico_id, YEAR(data_atendimento) AS ano, MONTH(data_atendimento) AS mes, COUNT(*) AS total
FROM atendimentos
GROUP BY servico_id, ano, mes;
