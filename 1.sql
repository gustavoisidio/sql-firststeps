CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    major VARCHAR(20)
    
    -- PRIMARY KEY pode vir ja na declaracao da variavel
    -- AUTO_INCREMENT deixa uma variavel incrementando sozinha. Util pra quando eh um ID, por exemplo
);


DESCRIBE student; -- descreve a estrutura da tabela student

DROP TABLE student; -- Remove a tabela inteira

ALTER TABLE student ADD gpa DECIMAL(3,2); -- Adiciona em student uma coluna cujo tipo dos elementos eh float

ALTER TABLE student DROP COLUMN gpa -- remove a coluna gpa da tabela student 

-- Fazendo update 
UPDATE student
SET major = 'Tech'
WHERE major = 'Eng' OR major = 'Computer Science';

-- Fazendo update
UPDATE student
SET major = 'undicided'
WHERE major <> 'Tech';

-- Deletando instancia
DELETE FROM student
WHERE name = 'Jack';

-- DROP TABLE student;

-- Selecionando so um ou alguns atributos da tabela student
SELECT name
FROM student;

-- Selecionando so um ou alguns atributos da tabela student
-- Ordenando por um dos atributos
SELECT name, major
FROM student
ORDER BY name;
-- ORDER BY name DESC; -- Retornaria a ordem decrescente
-- ORDER BY name ASC; -- Retornaria a ordem crescente
-- ORDER BY name, major ASC; -- Ordenaria primeiramente pelo nome e depois pelo major (caso estivessem nomes repetidos, esses seriam ordenados pelo major)

-- Comparacoes
-- <, >, <=, >=, =, <>, AND, OR 

SELECT * 
FROM student
ORDER BY student_id 
LIMIT 2; -- limita a query pra 2 linhas

SELECT * 
FROM student
WHERE name IN ('Janna', 'Anna', 'Jose', 'Kate') AND major IN ('undicided', 'Tech'); -- Seleciona os nomes que estao dentro de um grupo e major que estao dentro de um grupo tambem


-- Povoamento 
SELECT * FROM student;
INSERT INTO student VALUES(2, 'Kate', 'Sociology'); -- Inserindo na tabela student
INSERT INTO student(name, major) VALUES('Jack', 'Mathematics'); -- Inserindo na tabela student sem definir o ID
INSERT INTO student(name, major) VALUES('Jose', 'Engineering');
INSERT INTO student(name, major) VALUES('Mike', 'Engineering');
INSERT INTO student(name, major) VALUES('Janna', 'Medicine');
INSERT INTO student(name, major) VALUES('Anna', 'Medicine');
INSERT INTO student(name, major) VALUES('Janna', 'Computer Science');



