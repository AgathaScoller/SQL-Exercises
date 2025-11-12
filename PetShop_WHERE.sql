CREATE DATABASE petshop IF NOT EXISTS petshop;
USE petshop;

-- 1. Animais da espécie 'Cachorro'
SELECT * FROM animais WHERE especie = 'Cachorro';

-- 2. Tutores cujo nome começa com 'A'
SELECT * FROM tutores WHERE nome LIKE 'A%';

-- 3. Produtos com estoque maior que 30
SELECT * FROM produtos WHERE estoque > 30;

-- 4. Funcionários admitidos depois de 2022-01-01
SELECT * FROM funcionarios WHERE data_admissao > '2022-01-01';

-- 5. Serviços com preço menor ou igual a 50
SELECT * FROM servicos WHERE preco <= 50;

-- 6. Animais com idade entre 2 e 4 anos
SELECT * FROM animais WHERE idade BETWEEN 2 AND 4;

-- 7. Tutores com email que termina em 'gmail.com'
SELECT * FROM tutores WHERE email LIKE '%gmail.com';

-- 8. Produtos cujo nome contém 'Ração'
SELECT * FROM produtos WHERE nome LIKE '%Ração%';

-- 9. Animais do sexo feminino
SELECT * FROM animais WHERE sexo = 'F';

-- 10. Funcionários que têm cargo de id 1 (Veterinário)
SELECT * FROM funcionarios WHERE cargo_id = 1;

-- 11. Produtos com preço diferente de 25.00
SELECT * FROM produtos WHERE preco <> 25.00;

-- 12. Tutores sem telefone cadastrado (telefone NULL ou vazio)
SELECT * FROM tutores WHERE telefone IS NULL OR telefone = '';

-- 13. Animais que não são gatos
SELECT * FROM animais WHERE especie <> 'Gato';

-- 14. Serviços com duração maior que 30 minutos
SELECT * FROM servicos WHERE duracao_min > 30;

-- 15. Funcionários admitidos em 2023
SELECT * FROM funcionarios WHERE YEAR(data_admissao) = 2023;

-- 16. Produtos com estoque entre 10 e 50
SELECT * FROM produtos WHERE estoque BETWEEN 10 AND 50;

-- 17. Tutores cujo nome contém 'Rodrigo' ou 'Maria'
SELECT * FROM tutores WHERE nome LIKE '%Rodrigo%' OR nome LIKE '%Maria%';

-- 18. Animais com idade menor que 2 anos e sexo masculino
SELECT * FROM animais WHERE idade < 2 AND sexo = 'M';

-- 19. Produtos com preço maior que 30 e estoque menor que 20
SELECT * FROM produtos WHERE preco > 30 AND estoque < 20;

-- 20. Serviços que não possuem descrição (NULL ou vazio)
SELECT * FROM servicos WHERE descricao IS NULL OR descricao = '';

-- 21. Tutores cujo nome não começa com 'M'
SELECT * FROM tutores WHERE nome NOT LIKE 'M%';

-- 22. Funcionários que não são administradores (cargo_id diferente de 4)
SELECT * FROM funcionarios WHERE cargo_id <> 4;

-- 23. Animais que têm tutor_id igual a 2
SELECT * FROM animais WHERE tutor_id = 2;

-- 24. Atendimentos feitos na data '2025-06-12'
SELECT * FROM atendimentos WHERE DATE(data_atendimento) = '2025-06-12';

-- 25. Animais cujo nome termina com 'a'
SELECT * FROM animais WHERE nome LIKE '%a';

-- 26. Tutores cujo email não contém 'hotmail'
SELECT * FROM tutores WHERE email NOT LIKE '%hotmail%';

-- 27. Produtos cujo nome começa com 'Shampoo'
SELECT * FROM produtos WHERE nome LIKE 'Shampoo%';

-- 28. Serviços com preço entre 40 e 80
SELECT * FROM servicos WHERE preco BETWEEN 40 AND 80;

-- 29. Funcionários admitidos antes de 2023-01-01
SELECT * FROM funcionarios WHERE data_admissao < '2023-01-01';

-- 30. Animais com idade NULL (não informado)
SELECT * FROM animais WHERE idade IS NULL;

-- 31. Tutores com telefone começando com '6199'
SELECT * FROM tutores WHERE telefone LIKE '6199%';

-- 32. Produtos com estoque diferente de 0
SELECT * FROM produtos WHERE estoque != 0;

-- 33. Atendimentos com observações que contêm 'dermatite'
SELECT * FROM atendimentos WHERE observacoes LIKE '%dermatite%';

-- 34. Animais que são gatos ou cachorros
SELECT * FROM animais WHERE especie IN ('Gato', 'Cachorro');

-- 35. Produtos que não estão em estoque (estoque = 0)
SELECT * FROM produtos WHERE estoque = 0;
