CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(20),
    major VARCHAR(20)
);

/*

DESCRIBE student; -- descreve a estrutura da tabela student

DROP TABLE student; -- Remove a tabela inteira

ALTER TABLE student ADD gpa DECIMAL(3,2); -- Adiciona em student uma coluna cujo tipo dos elementos eh float

ALTER TABLE student DROP COLUMN gpa -- remove a coluna gpa da tabela student 

*/

SELECT * FROM student;
INSERT INTO student VALUES(2, 'Kate', 'Sociology');

DESCRIBE student;

