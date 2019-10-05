-- 6. Uso de ORDER BY
-- Mostra o cpf, nome e salario de todas as mulheres que são empregadas ordenado pelo quanto elas ganham
SELECT e.CPF, e.nome, e.salario
FROM empregado e
WHERE e.sexo = 'F'
ORDER BY e.salario;

-- 46. Uso de ORDER BY
-- Mostra o cpf, nome e salario de todas as mulheres que são empregadas ordenado primeiramente pelo quanto elas ganham e, em caso de mesmo salário, a ordenacao se da pela data de nascimento
SELECT e.CPF, e.nome, e.salario
FROM empregado e
WHERE e.sexo = 'F'
ORDER BY e.salario, e.dt_nasc;

-- 23. Uso de WHERE + HAVING
SELECT * FROM empregado;
SELECT * FRom trabalha;

SELECT t.codigo_depto, COUNT(t.cpf) 
FROM trabalha t, empregado e
WHERE e.cpf = t.cpf
GROUP BY t.codigo_depto
HAVING MAX(e.salario) > 4000;

SELECT 

SELECT AVG(t.data_trabalha)
FROM trabalha t;

SELECT t.data_trabalha
FROM trabalha t;
-- 12. Criar FK Composta
-- 29. Junção usando FULL OUTER JOIN
-- 40. Uso de GRANT
-- 74. AFTER TRIGGER
-- 91. INSTEAD OF TRIGGER

-- 80. Uso de NEW e OLD em TRIGGER de atualização

CREATE OR REPLACE TRIGGER reducaoSal
BEFORE UPDATE ON empregado
FROM EACH ROW BEGIN
        IF :NEW.salario < OLD.salario THEN
            INSERT INTO trigger_test VALUES( 'Redução de salário' );
        END IF;
END;