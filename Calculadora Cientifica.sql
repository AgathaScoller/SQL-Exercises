CREATE DATABASE IF NOT EXISTS calculadora_cientifica;
USE calculadora_cientifica;

---Histórico
CREATE TABLE historico_operacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_operacao VARCHAR(50),
    entrada1 DOUBLE,
    entrada2 DOUBLE,
    resultado DOUBLE,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

---Soma

DELIMITER //
CREATE PROCEDURE somar(IN a DOUBLE, IN b DOUBLE)
BEGIN
    DECLARE resultado DOUBLE;
    SET resultado = a + b;
    INSERT INTO historico_operacoes (tipo_operacao, entrada1, entrada2, resultado)
    VALUES ('Soma', a, b, resultado);
    SELECT resultado AS Resultado;

END;
//
DELIMITER ;

---Subtrair

DELIMITER //
CREATE PROCEDURE subtrair(IN a DOUBLE, IN b DOUBLE)
BEGIN
    DECLARE resultado DOUBLE;
    SET resultado = a - b;
    INSERT INTO historico_operacoes (tipo_operacao, entrada1, entrada2, resultado)
    VALUES ('Subtração', a, b, resultado);
    SELECT resultado AS Resultado;
END;
//
DELIMITER ;

---Multiplicar

DELIMITER //
CREATE PROCEDURE multiplicar(IN a DOUBLE, IN b DOUBLE)
BEGIN
    DECLARE resultado DOUBLE;
    SET resultado = a * b;
    INSERT INTO historico_operacoes (tipo_operacao, entrada1, entrada2, resultado)
    VALUES ('Multiplicação', a, b, resultado);
    SELECT resultado AS Resultado;
END;
//
DELIMITER ;

---Divisão

DELIMITER //
CREATE PROCEDURE dividir(IN a DOUBLE, IN b DOUBLE)
BEGIN
    DECLARE resultado DOUBLE;
    IF b = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Divisão por zero.';
    ELSE
        SET resultado = a / b;
        INSERT INTO historico_operacoes (tipo_operacao, entrada1, entrada2, resultado)
        VALUES ('Divisão', a, b, resultado);
        SELECT resultado AS Resultado;
    END IF;
END;
//
DELIMITER ;

---Raiz Quadrada

DELIMITER //
CREATE PROCEDURE raiz_quadrada(IN a DOUBLE)
BEGIN
    DECLARE resultado DOUBLE;
    IF a < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Raiz de número negativo.';
    ELSE
        SET resultado = SQRT(a);
        INSERT INTO historico_operacoes (tipo_operacao, entrada1, entrada2, resultado)
        VALUES ('Raiz Quadrada', a, NULL, resultado);
        SELECT resultado AS Resultado;
    END IF;
END;
//
DELIMITER ;

---Potenciação

DELIMITER //
CREATE PROCEDURE potencia(IN base DOUBLE, IN expoente DOUBLE)
BEGIN
    DECLARE resultado DOUBLE;
    SET resultado = POW(base, expoente);
    INSERT INTO historico_operacoes (tipo_operacao, entrada1, entrada2, resultado)
    VALUES ('Potência', base, expoente, resultado);
    SELECT resultado AS Resultado;
END;
//
DELIMITER ;

---Log

DELIMITER //
CREATE PROCEDURE logaritmo(IN a DOUBLE)
BEGIN
    DECLARE resultado DOUBLE;
    IF a <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Logaritmo de valor menor ou igual a zero.';
    ELSE
        SET resultado = LN(a);
        INSERT INTO historico_operacoes (tipo_operacao, entrada1, entrada2, resultado)
        VALUES ('Logaritmo Natural', a, NULL, resultado);
        SELECT resultado AS Resultado;
    END IF;
END;
//
DELIMITER ;

---Função trigonometrica

DELIMITER //
CREATE PROCEDURE seno(IN angulo DOUBLE)
BEGIN
    DECLARE resultado DOUBLE;
    SET resultado = SIN(angulo);
    INSERT INTO historico_operacoes (tipo_operacao, entrada1, entrada2, resultado)
    VALUES ('Seno', angulo, NULL, resultado);
    SELECT resultado AS Resultado;
END;
//

CREATE PROCEDURE cosseno(IN angulo DOUBLE)
BEGIN
    DECLARE resultado DOUBLE;
    SET resultado = COS(angulo);
    INSERT INTO historico_operacoes (tipo_operacao, entrada1, entrada2, resultado)
    VALUES ('Cosseno', angulo, NULL, resultado);
    SELECT resultado AS Resultado;
END;
//

CREATE PROCEDURE tangente(IN angulo DOUBLE)
BEGIN
    DECLARE resultado DOUBLE;
    SET resultado = TAN(angulo);
    INSERT INTO historico_operacoes (tipo_operacao, entrada1, entrada2, resultado)
    VALUES ('Tangente', angulo, NULL, resultado);
    SELECT resultado AS Resultado;
END;
//
DELIMITER ;

---Consulta 

SELECT * FROM historico_operacoes ORDER BY data_hora DESC;

---Execução

CALL somar(10, 5);
CALL dividir(10, 0); -- Mostra erro
CALL raiz_quadrada(25);
CALL logaritmo(10);
CALL seno(1.57); -- Aproximadamente π/2 radianos

---Apagar historico

TRUNCATE TABLE historico_operacoes;



