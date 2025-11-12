CREATE DATABASE petshop IF NOT EXISTS petshop;
USE petshop;

-- 1. Pegar os primeiros 5 animais
SELECT * FROM animais LIMIT 5;

-- 2. Pegar os primeiros 10 produtos
SELECT * FROM produtos LIMIT 10;

-- 3. Pegar 3 tutores ordenados por nome
SELECT * FROM tutores ORDER BY nome ASC LIMIT 3;

-- 4. Pegar os 2 serviços mais caros
SELECT * FROM servicos ORDER BY preco DESC LIMIT 2;

-- 5. Pegar 7 funcionários admitidos mais recentemente
SELECT * FROM funcionarios ORDER BY data_admissao DESC LIMIT 7;

-- 6. Pegar 10 produtos com estoque maior que 20
SELECT * FROM produtos WHERE estoque > 20 LIMIT 10;

-- 7. Pegar 4 animais do tutor com id 1
SELECT * FROM animais WHERE tutor_id = 1 LIMIT 4;

-- 8. Pegar 5 atendimentos mais recentes
SELECT * FROM atendimentos ORDER BY data_atendimento DESC LIMIT 5;

-- 9. Pegar os primeiros 6 tutores que têm email com domínio gmail.com
SELECT * FROM tutores WHERE email LIKE '%gmail.com' LIMIT 6;

-- 10. Pegar os 3 funcionários com cargo de Veterinário (cargo_id = 1)
SELECT * FROM funcionarios WHERE cargo_id = 1 LIMIT 3;

-- 11. Pegar 8 produtos com preço entre 30 e 100
SELECT * FROM produtos WHERE preco BETWEEN 30 AND 100 LIMIT 8;

-- 12. Pegar 5 serviços com duração maior que 30 minutos
SELECT * FROM servicos WHERE duracao_min > 30 LIMIT 5;

-- 13. Pegar 2 animais da espécie 'Gato' ordenados por idade
SELECT * FROM animais WHERE especie = 'Gato' ORDER BY idade ASC LIMIT 2;

-- 14. Pegar 10 tutores que moram na Asa Norte (endereco contém 'Asa Norte')
SELECT * FROM tutores WHERE endereco LIKE '%Asa Norte%' LIMIT 10;

-- 15. Pegar 5 produtos com estoque zero (indisponíveis)
SELECT * FROM produtos WHERE estoque = 0 LIMIT 5;

-- 16. Pegar 4 atendimentos de um funcionário específico (funcionario_id = 1)
SELECT * FROM atendimentos WHERE funcionario_id = 1 LIMIT 4;

-- 17. Pegar os 7 tutores mais antigos na base (ordenados por id)
SELECT * FROM tutores ORDER BY id ASC LIMIT 7;

-- 18. Pegar os 3 últimos animais cadastrados (ordenados por id desc)
SELECT * FROM animais ORDER BY id DESC LIMIT 3;

-- 19. Pegar os 5 produtos com menor estoque
SELECT * FROM produtos ORDER BY estoque ASC LIMIT 5;

-- 20. Pegar os 6 serviços mais baratos
SELECT * FROM servicos ORDER BY preco ASC LIMIT 6;

-- 21. Pegar os 5 primeiros funcionários com nome começando com 'F'
SELECT * FROM funcionarios WHERE nome LIKE 'F%' LIMIT 5;

-- 22. Pegar 3 tutores que não possuem telefone cadastrado
SELECT * FROM tutores WHERE telefone IS NULL OR telefone = '' LIMIT 3;

-- 23. Pegar 10 animais ordenados por tutor_id e nome
SELECT * FROM animais ORDER BY tutor_id ASC, nome ASC LIMIT 10;

-- 24. Pegar 5 produtos cujo nome contenha 'Coleira'
SELECT * FROM produtos WHERE nome LIKE '%Coleira%' LIMIT 5;

-- 25. Pegar os 4 atendimentos realizados no dia 2025-06-12
SELECT * FROM atendimentos WHERE DATE(data_atendimento) = '2025-06-12' LIMIT 4;

-- 26. Pegar 3 tutores com mais de um animal (usando HAVING)
SELECT t.nome, COUNT(a.id) AS total_animais
FROM tutores t
JOIN animais a ON t.id = a.tutor_id
GROUP BY t.id
HAVING COUNT(a.id) > 1
LIMIT 3;

-- 27. Pegar 7 animais do tutor 'Ana Paula' (precisa JOIN)
SELECT a.*
FROM animais a
JOIN tutores t ON a.tutor_id = t.id
WHERE t.nome = 'Ana Paula'
LIMIT 7;

-- 28. Pegar os 10 serviços mais longos (duração maior)
SELECT * FROM servicos ORDER BY duracao_min DESC LIMIT 10;

-- 29. Pegar os 5 últimos atendimentos de um animal específico (animal_id = 1)
SELECT * FROM atendimentos WHERE animal_id = 1 ORDER BY data_atendimento DESC LIMIT 5;

-- 30. Pegar 6 funcionários ordenados pelo cargo e nome
SELECT f.nome, c.nome AS cargo
FROM funcionarios f
JOIN cargos c ON f.cargo_id = c.id
ORDER BY c.nome ASC, f.nome ASC
LIMIT 6;

-- 31. Pegar 8 produtos ordenados pelo preço e estoque
SELECT * FROM produtos ORDER BY preco DESC, estoque ASC LIMIT 8;

-- 32. Pegar 5 tutores com e-mails terminando em 'hotmail.com'
SELECT * FROM tutores WHERE email LIKE '%hotmail.com' LIMIT 5;

-- 33. Pegar 4 animais que são cachorros e têm idade maior que 3
SELECT * FROM animais WHERE especie = 'Cachorro' AND idade > 3 LIMIT 4;

-- 34. Pegar os 10 primeiros atendimentos ordenados por data
SELECT * FROM atendimentos ORDER BY data_atendimento ASC LIMIT 10;

-- 35. Pegar 5 produtos com estoque entre 10 e 50 e preço menor que 100
SELECT * FROM produtos WHERE estoque BETWEEN 10 AND 50 AND preco < 100 LIMIT 5;
