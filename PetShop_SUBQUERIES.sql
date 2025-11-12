CREATE DATABASE petshop IF NOT EXISTS petshop;
USE petshop;

-- 1. Tutores que possuem mais de 2 animais
SELECT nome FROM tutores WHERE id IN (
  SELECT tutor_id FROM animais GROUP BY tutor_id HAVING COUNT(*) > 2
);

-- 2. Animais que têm tutor com telefone começando com '6199'
SELECT * FROM animais WHERE tutor_id IN (
  SELECT id FROM tutores WHERE telefone LIKE '6199%'
);

-- 3. Produtos com preço maior que a média de preço dos produtos
SELECT * FROM produtos WHERE preco > (
  SELECT AVG(preco) FROM produtos
);

-- 4. Funcionários admitidos depois da média das datas de admissão
SELECT * FROM funcionarios WHERE data_admissao > (
  SELECT AVG(UNIX_TIMESTAMP(data_admissao)) FROM funcionarios
);

-- 5. Serviços cujo preço é maior que o máximo preço dos serviços com duração menor que 30 min
SELECT * FROM servicos WHERE preco > (
  SELECT MAX(preco) FROM servicos WHERE duracao_min < 30
);

-- 6. Animais com idade maior que a média de idade dos animais
SELECT * FROM animais WHERE idade > (
  SELECT AVG(idade) FROM animais
);

-- 7. Tutores que não possuem animais cadastrados
SELECT * FROM tutores WHERE id NOT IN (
  SELECT DISTINCT tutor_id FROM animais
);

-- 8. Produtos cujo estoque é menor que a média de estoque
SELECT * FROM produtos WHERE estoque < (
  SELECT AVG(estoque) FROM produtos
);

-- 9. Animais cujo tutor tem nome que contém 'Ana'
SELECT * FROM animais WHERE tutor_id IN (
  SELECT id FROM tutores WHERE nome LIKE '%Ana%'
);

-- 10. Funcionários cujo cargo_id é igual ao cargo de 'Carla Ribeiro'
SELECT * FROM funcionarios WHERE cargo_id = (
  SELECT cargo_id FROM funcionarios WHERE nome = 'Carla Ribeiro' LIMIT 1
);

-- 11. Tutores com mais de um animal e cujo nome contém 'Maria'
SELECT * FROM tutores WHERE nome LIKE '%Maria%' AND id IN (
  SELECT tutor_id FROM animais GROUP BY tutor_id HAVING COUNT(*) > 1
);

-- 12. Animais que receberam atendimento na data mais recente registrada
SELECT * FROM animais WHERE id IN (
  SELECT animal_id FROM atendimentos WHERE data_atendimento = (
    SELECT MAX(data_atendimento) FROM atendimentos
  )
);

-- 13. Produtos cujo preço está entre o mínimo e máximo dos preços dos produtos
SELECT * FROM produtos WHERE preco BETWEEN (
  SELECT MIN(preco) FROM produtos
) AND (
  SELECT MAX(preco) FROM produtos
);

-- 14. Funcionários que não realizaram nenhum atendimento
SELECT * FROM funcionarios WHERE id NOT IN (
  SELECT DISTINCT funcionario_id FROM atendimentos
);

-- 15. Serviços que nunca foram realizados em atendimentos
SELECT * FROM servicos WHERE id NOT IN (
  SELECT DISTINCT servico_id FROM atendimentos
);

-- 16. Tutores cujo telefone não está cadastrado (null ou vazio)
SELECT * FROM tutores WHERE telefone IS NULL OR telefone = '';

-- 17. Animais com nome igual ao de algum tutor
SELECT * FROM animais WHERE nome IN (
  SELECT nome FROM tutores
);

-- 18. Produtos que têm preço maior que a média dos produtos com estoque maior que 10
SELECT * FROM produtos WHERE preco > (
  SELECT AVG(preco) FROM produtos WHERE estoque > 10
);

-- 19. Atendimentos realizados por funcionários que têm cargo 'Veterinário'
SELECT * FROM atendimentos WHERE funcionario_id IN (
  SELECT id FROM funcionarios WHERE cargo_id = (
    SELECT id FROM cargos WHERE nome = 'Veterinário' LIMIT 1
  )
);

-- 20. Tutores cujo nome começa com 'R' e que têm animais com idade maior que 3
SELECT * FROM tutores WHERE nome LIKE 'R%' AND id IN (
  SELECT tutor_id FROM animais WHERE idade > 3
);

-- 21. Animais que não receberam atendimento algum
SELECT * FROM animais WHERE id NOT IN (
  SELECT DISTINCT animal_id FROM atendimentos
);

-- 22. Produtos que estão com estoque zero
SELECT * FROM produtos WHERE estoque = 0;

-- 23. Funcionários admitidos no ano de 2023
SELECT * FROM funcionarios WHERE YEAR(data_admissao) = 2023;

-- 24. Animais cujo tutor possui mais de 3 animais
SELECT * FROM animais WHERE tutor_id IN (
  SELECT tutor_id FROM animais GROUP BY tutor_id HAVING COUNT(*) > 3
);

-- 25. Tutores que possuem animais da espécie 'Gato'
SELECT * FROM tutores WHERE id IN (
  SELECT tutor_id FROM animais WHERE especie = 'Gato'
);

-- 26. Produtos cujo preço é maior que o preço médio dos produtos vendidos em atendimentos
SELECT * FROM produtos WHERE preco > (
  SELECT AVG(s.preco)
  FROM atendimentos at
  JOIN servicos s ON at.servico_id = s.id
);

-- 27. Atendimentos que ocorreram na data mais antiga registrada
SELECT * FROM atendimentos WHERE data_atendimento = (
  SELECT MIN(data_atendimento) FROM atendimentos
);

-- 28. Funcionários que receberam atendimento no último mês (exemplo: junho de 2025)
SELECT * FROM funcionarios WHERE id IN (
  SELECT funcionario_id FROM atendimentos WHERE data_atendimento BETWEEN '2025-06-01' AND '2025-06-30'
);

-- 29. Tutores que não possuem email cadastrado
SELECT * FROM tutores WHERE email IS NULL OR email = '';

-- 30. Animais que têm mais de 4 anos e receberam atendimento em 2025
SELECT * FROM animais WHERE idade > 4 AND id IN (
  SELECT animal_id FROM atendimentos WHERE YEAR(data_atendimento) = 2025
);

-- 31. Serviços que custam menos que o menor preço entre os serviços com duração acima de 40 minutos
SELECT * FROM servicos WHERE preco < (
  SELECT MIN(preco) FROM servicos WHERE duracao_min > 40
);

-- 32. Tutores que têm nome e email iguais (exemplo para encontrar possíveis duplicados)
SELECT * FROM tutores WHERE nome IN (
  SELECT nome FROM tutores GROUP BY nome, email HAVING COUNT(*) > 1
);

-- 33. Animais cujo tutor tem telefone que começa com '618'
SELECT * FROM animais WHERE tutor_id IN (
  SELECT id FROM tutores WHERE telefone LIKE '618%'
);

-- 34. Produtos que possuem estoque maior que o estoque médio dos produtos
SELECT * FROM produtos WHERE estoque > (
  SELECT AVG(estoque) FROM produtos
);

-- 35. Atendimentos que foram feitos por funcionários cujo cargo é 'Banho e Tosa'
SELECT * FROM atendimentos WHERE funcionario_id IN (
  SELECT id FROM funcionarios WHERE cargo_id = (
    SELECT id FROM cargos WHERE nome = 'Banho e Tosa' LIMIT 1
  )
);
