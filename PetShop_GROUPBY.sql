CREATE DATABASE petshop IF NOT EXISTS petshop;
USE petshop;

-- 1. Contar quantos animais existem por espécie
SELECT especie, COUNT(*) AS total_animais
FROM animais
GROUP BY especie;

-- 2. Contar quantos tutores existem por cidade (assumindo endereço contém cidade)
SELECT SUBSTRING_INDEX(endereco, ',', -1) AS cidade, COUNT(*) AS total_tutores
FROM tutores
GROUP BY cidade;

-- 3. Quantidade de funcionários por cargo
SELECT cargo_id, COUNT(*) AS total_funcionarios
FROM funcionarios
GROUP BY cargo_id;

-- 4. Média de idade dos animais por espécie
SELECT especie, AVG(idade) AS idade_media
FROM animais
GROUP BY especie;

-- 5. Soma do estoque total por produto
SELECT nome, SUM(estoque) AS estoque_total
FROM produtos
GROUP BY nome;

-- 6. Preço médio dos serviços por duração (duracao_min)
SELECT duracao_min, AVG(preco) AS preco_medio
FROM servicos
GROUP BY duracao_min;

-- 7. Contagem de animais por tutor
SELECT tutor_id, COUNT(*) AS total_animais
FROM animais
GROUP BY tutor_id;

-- 8. Contagem de atendimentos por serviço
SELECT servico_id, COUNT(*) AS total_atendimentos
FROM atendimentos
GROUP BY servico_id;

-- 9. Contagem de atendimentos por funcionário
SELECT funcionario_id, COUNT(*) AS total_atendimentos
FROM atendimentos
GROUP BY funcionario_id;

-- 10. Contagem de animais por sexo
SELECT sexo, COUNT(*) AS total
FROM animais
GROUP BY sexo;

-- 11. Contagem de produtos com preço igual por nome
SELECT nome, COUNT(*) AS quantidade
FROM produtos
GROUP BY nome, preco;

-- 12. Soma total do estoque de produtos por faixa de preço (exemplo: preços arredondados)
SELECT FLOOR(preco/50)*50 AS faixa_preco, SUM(estoque) AS estoque_total
FROM produtos
GROUP BY faixa_preco;

-- 13. Média do preço dos produtos por nome
SELECT nome, AVG(preco) AS preco_medio
FROM produtos
GROUP BY nome;

-- 14. Contagem de tutores com email por domínio
SELECT SUBSTRING_INDEX(email, '@', -1) AS dominio, COUNT(*) AS total
FROM tutores
GROUP BY dominio;

-- 15. Contagem de atendimentos por data
SELECT DATE(data_atendimento) AS data, COUNT(*) AS total_atendimentos
FROM atendimentos
GROUP BY data;

-- 16. Contagem de funcionários admitidos por ano
SELECT YEAR(data_admissao) AS ano, COUNT(*) AS total_admitidos
FROM funcionarios
GROUP BY ano;

-- 17. Contagem de serviços por faixa de preço (exemplo: arredondado para dezenas)
SELECT FLOOR(preco/10)*10 AS faixa_preco, COUNT(*) AS total_servicos
FROM servicos
GROUP BY faixa_preco;

-- 18. Contagem de animais por raça
SELECT raca, COUNT(*) AS total_animais
FROM animais
GROUP BY raca;

-- 19. Contagem de tutores por nome (nome repetido)
SELECT nome, COUNT(*) AS total
FROM tutores
GROUP BY nome
HAVING COUNT(*) > 1;

-- 20. Soma do estoque de produtos agrupados por nome e preço
SELECT nome, preco, SUM(estoque) AS estoque_total
FROM produtos
GROUP BY nome, preco;

-- 21. Contagem de atendimentos por serviço e funcionário
SELECT servico_id, funcionario_id, COUNT(*) AS total_atendimentos
FROM atendimentos
GROUP BY servico_id, funcionario_id;

-- 22. Contagem de tutores por telefone (ver duplicados)
SELECT telefone, COUNT(*) AS total
FROM tutores
GROUP BY telefone
HAVING COUNT(*) > 1;

-- 23. Contagem de animais com idade maior que 3 anos por espécie
SELECT especie, COUNT(*) AS total
FROM animais
WHERE idade > 3
GROUP BY especie;

-- 24. Média da idade dos animais por tutor
SELECT tutor_id, AVG(idade) AS idade_media
FROM animais
GROUP BY tutor_id;

-- 25. Soma do preço dos serviços por nome
SELECT nome, SUM(preco) AS preco_total
FROM servicos
GROUP BY nome;

-- 26. Contagem de funcionários por cargo com mais de 1 funcionário
SELECT cargo_id, COUNT(*) AS total
FROM funcionarios
GROUP BY cargo_id
HAVING COUNT(*) > 1;

-- 27. Contagem de animais por tutor e espécie
SELECT tutor_id, especie, COUNT(*) AS total
FROM animais
GROUP BY tutor_id, especie;

-- 28. Contagem de atendimentos por mês (usando função MONTH)
SELECT YEAR(data_atendimento) AS ano, MONTH(data_atendimento) AS mes, COUNT(*) AS total
FROM atendimentos
GROUP BY ano, mes;

-- 29. Contagem de produtos por estoque zero e não zero
SELECT CASE WHEN estoque = 0 THEN 'Sem estoque' ELSE 'Com estoque' END AS status_estoque, COUNT(*) AS total
FROM produtos
GROUP BY status_estoque;

-- 30. Média de preço dos produtos por estoque disponível (agrupado em estoque > 0 e estoque = 0)
SELECT 
  CASE WHEN estoque > 0 THEN 'Em estoque' ELSE 'Sem estoque' END AS status_estoque, 
  AVG(preco) AS preco_medio
FROM produtos
GROUP BY status_estoque;
