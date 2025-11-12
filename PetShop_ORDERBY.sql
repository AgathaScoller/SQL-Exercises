CREATE DATABASE petshop IF NOT EXISTS petshop;
USE petshop;

-- 1. Listar animais ordenados por idade crescente
SELECT * FROM animais ORDER BY idade ASC;

-- 2. Listar tutores ordenados por nome em ordem alfabética
SELECT * FROM tutores ORDER BY nome ASC;

-- 3. Listar produtos ordenados pelo preço do mais caro para o mais barato
SELECT * FROM produtos ORDER BY preco DESC;

-- 4. Funcionários ordenados pela data de admissão mais recente primeiro
SELECT * FROM funcionarios ORDER BY data_admissao DESC;

-- 5. Serviços ordenados pelo nome em ordem alfabética inversa
SELECT * FROM servicos ORDER BY nome DESC;

-- 6. Animais ordenados por espécie e depois por nome
SELECT * FROM animais ORDER BY especie ASC, nome ASC;

-- 7. Produtos ordenados por estoque (do menor para o maior) e depois por nome
SELECT * FROM produtos ORDER BY estoque ASC, nome ASC;

-- 8. Tutores ordenados pela quantidade de animais que possuem (usando JOIN)
SELECT t.nome, COUNT(a.id) AS total_animais
FROM tutores t
LEFT JOIN animais a ON t.id = a.tutor_id
GROUP BY t.id
ORDER BY total_animais DESC;

-- 9. Atendimentos ordenados por data e hora do atendimento mais recente primeiro
SELECT * FROM atendimentos ORDER BY data_atendimento DESC;

-- 10. Funcionários ordenados por cargo e depois por nome
SELECT f.nome, c.nome AS cargo
FROM funcionarios f
JOIN cargos c ON f.cargo_id = c.id
ORDER BY c.nome ASC, f.nome ASC;

-- 11. Produtos ordenados por preço, depois por estoque em ordem decrescente
SELECT * FROM produtos ORDER BY preco ASC, estoque DESC;

-- 12. Serviços ordenados por duração e preço
SELECT * FROM servicos ORDER BY duracao_min ASC, preco DESC;

-- 13. Animais ordenados por tutor e depois por idade
SELECT * FROM animais ORDER BY tutor_id ASC, idade DESC;

-- 14. Tutores ordenados pelo domínio do email
SELECT * FROM tutores ORDER BY SUBSTRING_INDEX(email, '@', -1) ASC;

-- 15. Produtos ordenados por nome e depois pelo tamanho da descrição
SELECT nome, LENGTH(descricao) AS tamanho_descricao FROM produtos ORDER BY nome ASC, tamanho_descricao DESC;

-- 16. Atendimentos ordenados por serviço e data do atendimento
SELECT * FROM atendimentos ORDER BY servico_id ASC, data_atendimento DESC;

-- 17. Funcionários ordenados por ano de admissão
SELECT * FROM funcionarios ORDER BY YEAR(data_admissao) ASC;

-- 18. Animais ordenados pelo sexo (F antes de M) e depois por nome
SELECT * FROM animais ORDER BY sexo ASC, nome ASC;

-- 19. Produtos ordenados pelo estoque, mostrando os que estão zerados por último
SELECT * FROM produtos ORDER BY estoque = 0, estoque ASC;

-- 20. Serviços ordenados pelo preço em ordem decrescente
SELECT * FROM servicos ORDER BY preco DESC;

-- 21. Tutores ordenados pelo número de letras no nome (mais curto primeiro)
SELECT * FROM tutores ORDER BY LENGTH(nome) ASC;

-- 22. Animais ordenados por idade e espécie, ambos em ordem decrescente
SELECT * FROM animais ORDER BY idade DESC, especie DESC;

-- 23. Funcionários ordenados por cargo, em ordem decrescente
SELECT f.nome, c.nome AS cargo FROM funcionarios f JOIN cargos c ON f.cargo_id = c.id ORDER BY c.nome DESC;

-- 24. Produtos ordenados por preço, colocando os produtos mais baratos primeiro e se empate, pelo nome
SELECT * FROM produtos ORDER BY preco ASC, nome ASC;

-- 25. Tutores ordenados por telefone, do maior para o menor
SELECT * FROM tutores ORDER BY telefone DESC;

-- 26. Animais ordenados pela data do atendimento mais recente (JOIN com atendimentos)
SELECT a.nome, MAX(at.data_atendimento) AS ultimo_atendimento
FROM animais a
LEFT JOIN atendimentos at ON a.id = at.animal_id
GROUP BY a.id
ORDER BY ultimo_atendimento DESC;

-- 27. Atendimentos ordenados por funcionário e data
SELECT * FROM atendimentos ORDER BY funcionario_id ASC, data_atendimento DESC;

-- 28. Produtos ordenados por estoque em ordem decrescente
SELECT * FROM produtos ORDER BY estoque DESC;

-- 29. Tutores ordenados por email em ordem inversa
SELECT * FROM tutores ORDER BY email DESC;

-- 30. Serviços ordenados pelo nome em ordem alfabética
SELECT * FROM servicos ORDER BY nome ASC;

-- 31. Funcionários ordenados por nome e data de admissão
SELECT * FROM funcionarios ORDER BY nome ASC, data_admissao DESC;

-- 32. Animais ordenados por tutor e idade
SELECT * FROM animais ORDER BY tutor_id ASC, idade ASC;

-- 33. Atendimentos ordenados por serviço e tutor (JOIN)
SELECT at.*, t.nome AS tutor_nome
FROM atendimentos at
JOIN animais a ON at.animal_id = a.id
JOIN tutores t ON a.tutor_id = t.id
ORDER BY at.servico_id ASC, tutor_nome ASC;

-- 34. Produtos ordenados pelo comprimento do nome
SELECT * FROM produtos ORDER BY LENGTH(nome) DESC;

-- 35. Tutores ordenados pela data do último atendimento do seu animal
SELECT t.nome, MAX(at.data_atendimento) AS ultimo_atendimento
FROM tutores t
LEFT JOIN animais a ON t.id = a.tutor_id
LEFT JOIN atendimentos at ON a.id = at.animal_id
GROUP BY t.id
ORDER BY ultimo_atendimento DESC;
